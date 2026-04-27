import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MessageTabAllScreen/ChatScreen/Controller/chat_controller.dart';

import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';

class DirectChatScreen extends StatelessWidget {
  const DirectChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatItem item = (Get.arguments as ChatItem?) ??
        const ChatItem(
          id: '0',
          name: "John Lura",
          lastMsg: "Dummy message",
          time: "12:00 PM",
          avatar: "assets/images/onboarding1_img.jpg",
          unread: 0,
        );
    final c = Get.find<ChatController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        showBack: true,
        leadingWidget: ClipOval(
          child: AppImage(
            path: "assets/images/onboarding1_img.jpg",
            width: 46.w,
            height: 46.h,
            fit: BoxFit.cover,
          ),
        ),
        title: "John Lura",
        titleColor: ConstColor.primaryColor,
        subTitle: ConstString.activeNow,
        actions: [
          Icon(Icons.more_vert, size: 24.sp, color: const Color(0xFF635BFE)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: c.directMessages.length,
              itemBuilder: (_, i) => _DirectMessage(msg: c.directMessages[i]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _ChatInputBar(),
    );
  }
}

class _DirectMessage extends StatelessWidget {
  const _DirectMessage({required this.msg});

  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    if (msg.isMe) {
      return Padding(
        padding: EdgeInsets.only(bottom: 12.h, left: 60.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    title: msg.time,
                    textSize: 10.sp,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: msg.text,
                    textSize: 14.sp,
                    textColor: ConstColor.black,
                    maxLine: 10,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            _AvatarInitial(
              initial: 'E',
              color: ConstColor.primaryColor.withAlpha(80),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, right: 60.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AvatarInitial(
            initial: 'M',
            color: ConstColor.primaryColor.withAlpha(40),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: msg.senderName,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      title: msg.time,
                      textSize: 10.sp,
                      textColor: ConstColor.iconColor,
                      maxLine: 1,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: msg.text,
                  textSize: 15.sp,
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

// ── Shared input bar ──
class _ChatInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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

                  // Text Input
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
