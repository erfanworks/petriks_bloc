import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../ChatScreen/Controller/chat_controller.dart';

class ChatBottomSheet {
  static void show(
    BuildContext context, {
    bool isPlanChat = false,
    bool isDirect = false,
    String userName = '',
    String userImage = '',
  }) {
    final c = Get.find<ChatController>();
    final sheetTitle = isDirect
        ? 'Chat Options'
        : isPlanChat
            ? 'Plan Options'
            : ConstString.groupOptions;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ConstColor.borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              title: sheetTitle,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.primaryColor,
              maxLine: 1,
            ),
            SizedBox(height: 16.h),
            _OptionRow(
              icon: Icons.notifications_off_outlined,
              label: ConstString.muteNotifications,
              color: ConstColor.black,
              onTap: () => Get.back(),
            ),
            if (isDirect)
              _OptionRow(
                icon: Icons.block_rounded,
                label: ConstString.blockUser,
                color: Colors.red,
                onTap: () {
                  Get.back();
                  c.confirmBlockDirectUser(name: userName, image: userImage);
                },
              )
            else
              _OptionRow(
                icon: Icons.logout_rounded,
                label: isPlanChat ? 'Leave Plan' : ConstString.leaveGroup,
                color: Colors.red,
                onTap: () {
                  Get.back(); // sheet বন্ধ
                  isPlanChat ? c.confirmLeavePlan() : c.confirmLeaveCommunityChat();
                },
              ),
            _OptionRow(
              icon: Icons.flag_outlined,
              label: ConstString.report,
              color: ConstColor.black,
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.r, color: color),
            SizedBox(width: 14.w),
            CustomText(
              title: label,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              textColor: color,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}
