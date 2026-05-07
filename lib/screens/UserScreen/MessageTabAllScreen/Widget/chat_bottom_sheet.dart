import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';

class ChatBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
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
              title: ConstString.groupOptions,
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
            _OptionRow(
              icon: Icons.logout_rounded,
              label: ConstString.leaveGroup,
              color: Colors.red,
              onTap: () => Get.back(),
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
          children:[
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