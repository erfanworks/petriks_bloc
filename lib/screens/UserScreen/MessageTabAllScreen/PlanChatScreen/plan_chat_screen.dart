import 'dart:io';
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
            onTap: () => ChatBottomSheet.show(context, isPlanChat: true),
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
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 13.r,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  title: 'Sun, 26 Mar',
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.black,
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.location_on_outlined,
                  size: 13.r,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: CustomText(
                    title: 'Soho Café',
                    textSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.joinedPlanDetailsScreen),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: c.planMessages.length,
                itemBuilder: (_, i) {
                  final msg = c.planMessages[c.planMessages.length - 1 - i];
                  if (msg.isSystemMsg) return _SystemMessage(text: msg.text);
                  return _PlanChatMessage(msg: msg);
                },
              ),
            ),
          ),

          _ChatInputBar(),
        ],
      ),
    );
  }
}

class _PlanChatMessage extends StatefulWidget {
  const _PlanChatMessage({required this.msg});

  final ChatMessage msg;

  @override
  State<_PlanChatMessage> createState() => _PlanChatMessageState();
}

class _PlanChatMessageState extends State<_PlanChatMessage> {
  bool _showTime = false;

  @override
  Widget build(BuildContext context) {
    bool hasMedia =
        widget.msg.mediaPaths != null && widget.msg.mediaPaths!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () => setState(() => _showTime = !_showTime),
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
                  title: widget.msg.senderName.isNotEmpty
                      ? widget.msg.senderName[0]
                      : '?',
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.primaryColor,
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
                        title: widget.msg.senderName,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w700,
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
                            borderRadius: BorderRadius.circular(6.r),
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 240.w),
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.msg.mediaPaths!.length == 1 ? 1 : 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: widget.msg.mediaPaths!.length == 1 ? 1.5 : 1,
                          ),
                          itemCount: widget.msg.mediaPaths!.length,
                          itemBuilder: (_, i) => ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.file(
                              File(widget.msg.mediaPaths![i]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                  if (widget.msg.text.isNotEmpty)
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
              offset: Offset(0, -2.h),
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
                          top: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: () => c.selectedMediaPaths.removeAt(index),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 16.sp,
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
                  onTap: () => c.sendPlanMessage(),
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
              Icons.people_outline_rounded,
              size: 13.r,
              color: ConstColor.primaryColor,
            ),
            SizedBox(width: 5.w),
            CustomText(
              title: text,
              textSize: 11.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
