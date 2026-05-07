import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../ChatScreen/Controller/chat_controller.dart';
import '../Widget/chat_bottom_sheet.dart';

class PlanChatScreen extends StatelessWidget {
  const PlanChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments is ChatItem ? Get.arguments as ChatItem : null;
    final c    = Get.find<ChatController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        showBack: true,
        title: 'Sunday Brunch & Coffee C...',
        titleColor: ConstColor.primaryColor,
        subTitle: ConstString.fourParticipants,
        actions:[
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
        children: [
          // ── Date + location + View Plans bar ──
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 13.r, color: ConstColor.primaryColor),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Sun, Mar 26',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                SizedBox(width: 12.w),
                Icon(Icons.location_on_outlined,
                    size: 13.r, color: ConstColor.primaryColor),
                SizedBox(width: 4.w),
                Expanded(
                  child: CustomText(
                    title: 'Downtown Cafe',
                    textSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                ),
                // View Plans button
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.joinedPlanDetailsScreen),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: CustomText(
                      title: ConstString.viewPlans,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Messages ──
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 12.h),
              itemCount: c.messages.length,
              itemBuilder: (_, i) {
                final msg = c.messages[i];
                if (msg.isSystemMsg) return _SystemMessage(text: msg.text);
                return _PlanChatMessage(msg: msg);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _ChatInputBar(),
    );
  }
}

class _PlanChatMessage extends StatelessWidget {
  const _PlanChatMessage({required this.msg});
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                title: msg.senderName.isNotEmpty ? msg.senderName[0] : '?',
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.primaryColor,
                maxLine: 1,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: msg.senderName,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w700,
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
                          borderRadius: BorderRadius.circular(6.r),
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
                    SizedBox(width: 8.w),
                    CustomText(
                      title: msg.time,
                      textSize: 10.sp,
                      textColor: ConstColor.iconColor,
                      maxLine: 1,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Message text
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
          children: [
            Icon(Icons.people_outline_rounded,
                size: 13.r, color: ConstColor.primaryColor),
            SizedBox(width: 5.w),
            CustomText(
              title: text,
              textSize: 11.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.primaryColor,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}
class _ChatInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        5.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
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

                  // Emoji Icon
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