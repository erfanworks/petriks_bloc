import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MessageTabAllScreen/ChatScreen/Controller/chat_controller.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../Widget/chat_bottom_sheet.dart';

class DirectChatScreen extends StatelessWidget {
  const DirectChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatItem item =
        (Get.arguments as ChatItem?) ??
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
      resizeToAvoidBottomInset: true,
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
          Expanded(
            child: Obx(
              () => ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: c.directMessages.length,
                itemBuilder: (_, i) => _DirectMessage(
                  msg: c.directMessages[c.directMessages.length - 1 - i],
                ),
              ),
            ),
          ),
          _ChatInputBar(),
        ],
      ),
    );
  }
}

class _DirectMessage extends StatefulWidget {
  const _DirectMessage({super.key, required this.msg});
  final ChatMessage msg;

  @override
  State<_DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<_DirectMessage> {
  bool _showTime = false;

  @override
  Widget build(BuildContext context) {
    bool hasMedia = widget.msg.mediaPaths != null && widget.msg.mediaPaths!.isNotEmpty;
    bool hasText = widget.msg.text.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showTime = !_showTime;
          });
        },
        child: Column(
          crossAxisAlignment: widget.msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (hasMedia)
              Container(
                constraints: BoxConstraints(maxWidth: 250.w),
                margin: EdgeInsets.only(bottom: hasText ? 2.h : 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.msg.mediaPaths!.length == 1 ? 1 : 2,
                    crossAxisSpacing: 4.w,
                    mainAxisSpacing: 4.h,
                    childAspectRatio: widget.msg.mediaPaths!.length == 1 ? 1.2 : 1,
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
              Container(
                constraints: BoxConstraints(maxWidth: 260.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: widget.msg.isMe ? ConstColor.primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                    bottomLeft: Radius.circular(widget.msg.isMe ? 18.r : 4.r),
                    bottomRight: Radius.circular(widget.msg.isMe ? 4.r : 18.r),
                  ),
                ),
                child: CustomText(
                  title: widget.msg.text,
                  textColor: widget.msg.isMe ? Colors.white : Colors.black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

            if (_showTime)
              Padding(
                padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                child: CustomText(
                  title: widget.msg.time,
                  textSize: 10.sp,
                  textColor: ConstColor.textColor,
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
                height: 90.h,
                padding: EdgeInsets.only(bottom: 10.h),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.selectedMediaPaths.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            File(c.selectedMediaPaths[index]),
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10.w,
                        child: GestureDetector(
                          onTap: () => c.selectedMediaPaths.removeAt(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
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
                          child: Icon(
                            Icons.add_circle,
                            color: ConstColor.primaryColor,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: c.messageController,
                            decoration: const InputDecoration(
                              hintText: "Type message...",
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ConstColor.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () => c.sendDirectMessage(),
                  child: CircleAvatar(
                    backgroundColor: ConstColor.primaryColor,
                    child: Icon(Icons.send, color: Colors.white, size: 20.sp),
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
