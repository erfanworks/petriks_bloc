import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MessageTabAllScreen/ChatScreen/Controller/chat_controller.dart';

import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/chat_bottom_sheet.dart';

class GroupPlanChatScreen extends StatelessWidget {
  const GroupPlanChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item        = Get.arguments as ChatItem;
    final c           = Get.find<ChatController>();
    final isGroupTab  = c.selectedTab.value == 2;

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        showBack: true,
        title: 'Sunday Brunch & Coffee C...',
        titleColor: ConstColor.primaryColor,
        subTitle: ConstString.fourParticipants,
        actions:[
          // ── 3 Dot Icon (Bottom Sheet trigger) ──
          GestureDetector(
            onTap: () => ChatBottomSheet.show(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Icon(Icons.more_vert, size: 24.sp, color: ConstColor.textColor),
            ),
          ),
        ],
      ),
      body: Column(
        children:[
          Container(
            color: ConstColor.primaryColor.withAlpha(15),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children:[
                Icon(Icons.calendar_today_outlined,
                    size: 13.r, color: ConstColor.primaryColor),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Sun, Mar 26',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.primaryColor,
                  maxLine: 1,
                ),
                SizedBox(width: 16.w),
                Icon(Icons.location_on_outlined,
                    size: 13.r, color: ConstColor.primaryColor),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Downtown Cafe',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.primaryColor,
                  maxLine: 1,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 12.h),
              itemCount:
              c.messages.length + (isGroupTab ? 2 : 0),
              itemBuilder: (_, i) {
                if (isGroupTab) {
                  if (i == 0) {
                    return Column(
                      children:[
                        const _SystemMessage(text: 'You joined this plan'),
                        _CompetitionCard(),
                      ],
                    );
                  }

                  // 2. Bottom Message (Below all chats)
                  if (i == c.messages.length + 1) {
                    return const _SystemMessage(text: 'You joined this plan');
                  }

                  final idx = i - 1;
                  final msg = c.messages[idx];

                  // Hide the original one from the controller so it doesn't duplicate in the middle
                  if (msg.isSystemMsg && msg.text.toLowerCase().contains("joined")) {
                    return const SizedBox.shrink();
                  }

                  if (msg.isSystemMsg) return _SystemMessage(text: msg.text);
                  return _GroupMessage(msg: msg);
                }

                final msg = c.messages[i];
                if (msg.isSystemMsg) return _SystemMessage(text: msg.text);
                return _GroupMessage(msg: msg);
              },
            ),
          ),

          _ChatInputBar(),
        ],
      ),
    );
  }
}

class _GroupMessage extends StatelessWidget {
  const _GroupMessage({required this.msg});
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          _AvatarInitial(
            initial: msg.senderName.isNotEmpty
                ? msg.senderName[0]
                : '?',
            color: ConstColor.primaryColor.withAlpha(40),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children:[
                    CustomText(
                      title: msg.senderName,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                    if (msg.isHost) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: CustomText(
                          title: ConstString.host,
                          textSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.primaryColor,
                          maxLine: 1,
                        ),
                      ),
                    ],
                    SizedBox(width: 6.w),
                    CustomText(
                      title: msg.time,
                      textSize: 10.sp,
                      textColor: ConstColor.iconColor,
                      maxLine: 1,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: msg.text,
                  textSize: 13.sp,
                  textColor: ConstColor.black,
                  maxLine: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Image er moto design modify kora hoyeche ──
class _SystemMessage extends StatelessWidget {
  const _SystemMessage({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ConstColor.primaryColor.withAlpha(15),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            Icon(Icons.person_add_outlined, // Image er moton icon
                size: 15.r, color: ConstColor.iconColor),
            SizedBox(width: 6.w),
            CustomText(
              title: text,
              textSize: 11.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.iconColor, // Image er moton greyish text
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompetitionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF944A1A).withAlpha(40),width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children:[
              Expanded(
                child: Column(
                  children:[
                    Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                        color: ConstColor.primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CustomText(
                          title: 'A',
                          textSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          textColor: ConstColor.iconColor,
                          maxLine: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      title: ConstString.groupA,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      textColor: ConstColor.textColor,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
              Column(
                children:[
                  CustomText(
                    title: 'VS',
                    textSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    textColor: ConstColor.primaryColor,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: 'Sun 5PM',
                    textSize: 10.sp,
                    textColor: ConstColor.iconColor,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children:[
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: BoxDecoration(
                        color: ConstColor.primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: CustomText(
                          title: 'B',
                          textSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          textColor: ConstColor.iconColor,
                          maxLine: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      title: ConstString.groupB,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      textColor: ConstColor.textColor,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0E5),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Center(
                child: CustomText(
                  title: ConstString.viewCompetition,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: const Color(0xFF944A1A),
                  maxLine: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Group options bottom sheet ──




class _AvatarInitial extends StatelessWidget {
  const _AvatarInitial({required this.initial, required this.color});

  final String initial;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 40.r,
    height: 40.r,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    child: Center(
      child: CustomText(
        title: initial,
        textSize: 14.sp,
        fontWeight: FontWeight.w600,
        textColor: ConstColor.primaryColor,
        maxLine: 1,
      ),
    ),
  );
}

class _ChatInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow:[
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                16.w,
                0,
                16.w,
                5.h + MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children:[
                  GestureDetector(
                    onTap: () => Get.find<ChatController>().pickChatImage(),
                    child: SvgPicture.asset(
                      "assets/icons/add_icon.svg",
                      width: 25.w,
                      height: 25.h,
                      colorFilter: const ColorFilter.mode(
                        ConstColor.textColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: ConstString.typeAMessage,
                        hintStyle: TextStyle(
                          color: ConstColor.textColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ConstColor.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      size: 24.r,
                      color: ConstColor.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 48.r,
              height: 48.r,
              decoration: const BoxDecoration(
                color: ConstColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                  size: 22.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}