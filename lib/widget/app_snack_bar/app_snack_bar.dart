import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import '../text/custom_text.dart';
import 'error_snackbar_message.dart';

class AppSnackBar {

  // ─── Error ───────────────────────────────
  static void error(String parameterValue, {int seconds = 3}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ConstColor.red.withAlpha(230),
        animationDuration: const Duration(milliseconds: 400),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: ErrorSnackBarMessageWidget(errorMessage: parameterValue),
        borderRadius: 12.r,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        margin: EdgeInsets.only(
          top: 20.h,
          left: 16.w,
          right: 16.w,
        ),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  // ─── Success ─────────────────────────────
  static void success(String parameterValue, {int seconds = 3}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: ConstColor.primaryColor.withAlpha(150),
        animationDuration: const Duration(milliseconds: 400),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: _SuccessMessageWidget(message: parameterValue),
        borderRadius: 12.r,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        margin: EdgeInsets.only(
          top: 20.h,
          left: 16.w,
          right: 16.w,
        ),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  // ─── Message ─────────────────────────────
  static void message(
      String parameterValue, {
        Color backgroundColor = ConstColor.silverGray20,
        Color color = Colors.white,
        int seconds = 3,
      }) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor,
        animationDuration: const Duration(milliseconds: 400),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: CustomText(
          title: parameterValue,
          textColor: color,
          textSize: 14.sp,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w400,
        ),
        borderRadius: 12.r,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        margin: EdgeInsets.only(
          top: 20.h,
          left: 16.w,
          right: 16.w,
        ),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}

class _SuccessMessageWidget extends StatelessWidget {
  final String message;

  const _SuccessMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ─── Check Icon ──────────────────
        Container(
          width: 22.w,
          height: 22.h,
          decoration: const BoxDecoration(
            color: ConstColor.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 14.sp,
          ),
        ),
        SizedBox(width: 10.w),

        // ─── Message ─────────────────────
        Expanded(
          child: CustomText(
            title: message,
            textColor: ConstColor.white,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            maxLine: 2,
          ),
        ),
      ],
    );
  }
}