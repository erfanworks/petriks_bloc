import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ChatController());

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar ──
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: ConstString.chat,
                    textSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  Icon(
                    Icons.search_rounded,
                    size: 24.r,
                    color: ConstColor.black,
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // ── 3-tab toggle ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                () => Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: ConstColor.black.withAlpha(10),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: List.generate(c.tabs.length, (i) {
                      final selected = c.selectedTab.value == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => c.switchTab(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: selected
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(28.r),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(15),
                                        blurRadius: 6.r,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: CustomText(
                                title: c.tabs[i],
                                textSize: 14.sp,
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                textColor: selected
                                    ? ConstColor.primaryColor
                                    : ConstColor.iconColor,
                                maxLine: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: c.chats.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: ConstColor.borderColor.withAlpha(80),
                    indent: 72.w,
                  ),
                  itemBuilder: (_, i) => _ChatListTile(
                    item: c.chats[i],
                    onTap: () => c.openChat(c.chats[i]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatListTile extends StatelessWidget {
  const _ChatListTile({required this.item, required this.onTap});

  final ChatItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasUnread = item.unread > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: AppImage(
                    path: item.avatar,
                    width: 55.r,
                    height: 55.r,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 2.h,
                  right: 2.w,
                  child: Container(
                    width: 11.r,
                    height: 11.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ConstColor.backgroundColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.name,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: item.lastMsg,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    textColor: hasUnread ? ConstColor.black : ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  title: item.time,
                  textSize: 12.sp,
                  textColor: hasUnread
                      ? ConstColor.primaryColor
                      : ConstColor.grey,
                  fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w400,
                  maxLine: 1,
                ),
                if (hasUnread) ...[
                  SizedBox(height: 4.h),
                  Container(
                    width: 20.r,
                    height: 20.r,
                    decoration: const BoxDecoration(
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CustomText(
                        title: '${item.unread}',
                        textSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        maxLine: 1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
