import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
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
    final c = Get.find<ChatController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        showBack: true,
        title: 'Sunday Brunch & Coffee C...',
        titleColor: ConstColor.primaryColor,
        subTitle: ConstString.fourParticipants,
        actions: [
          GestureDetector(
            onTap: () => ChatBottomSheet.show(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Icon(
                Icons.more_vert,
                size: 24.sp,
                color: ConstColor.textColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: ConstColor.primaryColor.withAlpha(15),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 13.r,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Sun, Mar 26',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.primaryColor,
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.location_on_outlined,
                  size: 13.r,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Downtown Cafe',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.primaryColor,
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              final showCompetition = c.hasCompetition.value;
              final extraHeaderItems = showCompetition ? 2 : 1;

              return ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: c.messages.length + extraHeaderItems,
                itemBuilder: (_, i) {
                  if (i == c.messages.length + extraHeaderItems - 1) {
                    return const _SystemMessage(text: 'You joined this plan');
                  }
                  if (showCompetition && i == c.messages.length) {
                    return _CompetitionCard();
                  }

                  final msgIdx = c.messages.length - 1 - i;
                  final msg = c.messages[msgIdx];

                  if (msg.isSystemMsg &&
                      msg.text.toLowerCase().contains("joined")) {
                    return const SizedBox.shrink();
                  }

                  if (msg.isSystemMsg) return _SystemMessage(text: msg.text);
                  return _GroupMessage(msg: msg);
                },
              );
            }),
          ),

          _ChatInputBar(),
        ],
      ),
    );
  }
}

class _GroupMessage extends StatefulWidget {
  const _GroupMessage({required this.msg});

  final ChatMessage msg;

  @override
  State<_GroupMessage> createState() => _GroupMessageState();
}

class _GroupMessageState extends State<_GroupMessage> {
  bool _showTime = false;

  @override
  Widget build(BuildContext context) {
    bool hasMedia =
        widget.msg.mediaPaths != null && widget.msg.mediaPaths!.isNotEmpty;
    bool hasText = widget.msg.text.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: GestureDetector(
        onTap: () => setState(() => _showTime = !_showTime),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AvatarInitial(
              initial: widget.msg.senderName.isNotEmpty
                  ? widget.msg.senderName[0]
                  : '?',
              color: ConstColor.primaryColor.withAlpha(40),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        title: widget.msg.senderName,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.black,
                      ),
                      if (widget.msg.isHost) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ConstColor.primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomText(
                            title: ConstString.host,
                            textSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),

                  if (hasMedia)
                    Container(
                      constraints: BoxConstraints(maxWidth: 240.w),
                      margin: EdgeInsets.only(bottom: hasText ? 4.h : 0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: widget.msg.mediaPaths!.length == 1
                              ? 1
                              : 2,
                          crossAxisSpacing: 4.w,
                          mainAxisSpacing: 4.h,
                          childAspectRatio: widget.msg.mediaPaths!.length == 1
                              ? 1.5
                              : 1,
                        ),
                        itemCount: widget.msg.mediaPaths!.length,
                        itemBuilder: (_, i) => ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.file(
                            File(widget.msg.mediaPaths![i]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  if (hasText)
                    CustomText(
                      title: widget.msg.text,
                      textSize: 13.sp,
                      textColor: ConstColor.black,
                      maxLine: 10,
                    ),

                  if (_showTime)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: CustomText(
                        title: widget.msg.time,
                        textSize: 10.sp,
                        textColor: ConstColor.iconColor,
                      ),
                    ),
                ],
              ),
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
    final c = Get.find<ChatController>();

    return Obx(
      () => Container(
        padding: EdgeInsets.fromLTRB(
          16.w,
          8.h,
          16.w,
          8.h +
              MediaQuery.of(context).viewInsets.bottom +
              (MediaQuery.of(context).viewInsets.bottom > 0
                  ? 0
                  : MediaQuery.of(context).padding.bottom),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8.r,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (c.selectedMediaPaths.isNotEmpty)
              Container(
                height: 85.h,
                padding: EdgeInsets.only(bottom: 8.h),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.selectedMediaPaths.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            File(c.selectedMediaPaths[index]),
                            width: 70.w,
                            height: 70.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -5.h,
                          right: -5.w,
                          child: GestureDetector(
                            onTap: () => c.selectedMediaPaths.removeAt(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => c.pickChatImage(),
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
                            controller: c.messageController,
                            decoration: InputDecoration(
                              hintText: ConstString.typeAMessage,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ConstColor.black,
                            ),
                          ),
                        ),
                        // Icon(
                        //   Icons.sentiment_satisfied_alt_outlined,
                        //   size: 24.r,
                        //   color: ConstColor.textColor,
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () => c.sendGroupMessage(),
                  child: Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: const BoxDecoration(
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
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
          ],
        ),
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
            Icon(
              Icons.person_add_outlined,
              size: 15.r,
              color: ConstColor.iconColor,
            ),
            SizedBox(width: 6.w),
            CustomText(
              title: text,
              textSize: 11.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.iconColor,
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
      margin: EdgeInsets.only(bottom: 16.h, top: 10.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF944A1A).withAlpha(40),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _TeamInfo(initial: 'A', label: ConstString.groupA),
              _VersusInfo(),
              _TeamInfo(initial: 'B', label: ConstString.groupB),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {Get.toNamed(AppRoutes.viewCompetitionScreen);},
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamInfo extends StatelessWidget {
  final String initial, label;

  const _TeamInfo({required this.initial, required this.label});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomText(
              title: initial,
              textSize: 16.sp,
              fontWeight: FontWeight.w900,
              textColor: ConstColor.iconColor,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        CustomText(
          title: label,
          textSize: 11.sp,
          fontWeight: FontWeight.w500,
          textColor: ConstColor.textColor,
        ),
      ],
    ),
  );
}

class _VersusInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      CustomText(
        title: 'VS',
        textSize: 20.sp,
        fontWeight: FontWeight.w900,
        textColor: ConstColor.primaryColor,
      ),
      CustomText(
        title: 'Sun 5PM',
        textSize: 10.sp,
        textColor: ConstColor.iconColor,
        fontWeight: FontWeight.w500,
      ),
    ],
  );
}

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
      ),
    ),
  );
}
