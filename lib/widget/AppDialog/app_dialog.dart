import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../text/custom_text.dart';
import '../../constant/const_color.dart';

class AppDialogButton {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final List<Color>? gradient;

  const AppDialogButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.backgroundColor = ConstColor.primaryColor,
    this.textColor = Colors.white,
    this.isOutlined = false,
    this.gradient,
  });
}

class AppDialog {
  static Future<T?> show<T>({
    IconData? icon,
    Color iconColor = Colors.white,
    Color iconBackgroundColor = ConstColor.primaryColor,
    double iconSize = 34,
    double iconContainerSize = 72,
    required String title,
    Color titleColor = ConstColor.black,
    double titleSize = 18,

    String? message,
    Color messageColor = ConstColor.textColor,
    double messageSize = 14,
    TextAlign messageAlign = TextAlign.center,
    Widget? content,

    String? primaryButtonText,
    VoidCallback? onPrimaryTap,
    Color primaryButtonColor = ConstColor.primaryColor,
    Color primaryTextColor = Colors.white,

    String? secondaryButtonText,
    VoidCallback? onSecondaryTap,
    Color secondaryButtonColor = const Color(0xFFE5E5EA),
    Color secondaryTextColor = ConstColor.black,

    List<AppDialogButton>? buttons,

    bool barrierDismissible = true,

    Duration? autoDismissDuration,
    VoidCallback? onAutoDismiss,
  }) {
    Timer? autoTimer;

    if (autoDismissDuration != null) {
      autoTimer = Timer(autoDismissDuration, () {
        if (Get.isDialogOpen ?? false) Get.back();
        onAutoDismiss?.call();
      });
    }

    return Get.dialog<T>(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: iconContainerSize.r,
                  height: iconContainerSize.r,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: iconSize.sp),
                ),
                SizedBox(height: 16.h),
              ],

              CustomText(
                title: title,
                textSize: titleSize.sp,
                fontWeight: FontWeight.w700,
                textColor: titleColor,
                textAlign: TextAlign.center,
                maxLine: 2,
              ),

              if (message != null || content != null) SizedBox(height: 10.h),

              if (content != null)
                content
              else if (message != null)
                CustomText(
                  title: message,
                  textSize: messageSize.sp,
                  fontWeight: FontWeight.w400,
                  textColor: messageColor,
                  textAlign: messageAlign,
                  maxLine: 4,
                ),

              if (buttons != null) ...[
                SizedBox(height: 22.h),
                Column(
                  children: List.generate(buttons.length, (i) {
                    final b = buttons[i];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: i == buttons.length - 1 ? 0 : 10.h,
                      ),
                      child: GestureDetector(
                        onTap: b.onTap,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: b.gradient == null ? b.backgroundColor : null,
                            gradient: b.gradient != null
                                ? LinearGradient(colors: b.gradient!)
                                : null,
                            borderRadius: BorderRadius.circular(30.r),
                            border: b.isOutlined
                                ? Border.all(color: ConstColor.borderColor)
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                title: b.label,
                                textSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                textColor: b.textColor,
                                maxLine: 1,
                              ),
                              if (b.icon != null) ...[
                                SizedBox(width: 8.w),
                                Icon(b.icon, size: 18.sp, color: b.textColor),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ]
              else if (primaryButtonText != null) ...[
                SizedBox(height: 24.h),
                Row(
                  children: [
                    if (secondaryButtonText != null) ...[
                      Expanded(
                        child: GestureDetector(
                          onTap: onSecondaryTap ?? () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: secondaryButtonColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Center(
                              child: CustomText(
                                title: secondaryButtonText,
                                textSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                textColor: secondaryTextColor,
                                maxLine: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                    Expanded(
                      child: GestureDetector(
                        onTap: onPrimaryTap ?? () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: primaryButtonColor,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: CustomText(
                              title: primaryButtonText,
                              textSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              textColor: primaryTextColor,
                              maxLine: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    ).whenComplete(() => autoTimer?.cancel());
  }
}