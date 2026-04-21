import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/phone_number_verify_otp_controller.dart';

class PhoneNumberVerifyOtpScreen extends StatelessWidget {
  const PhoneNumberVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhoneNumberVerifyOtpController>();

    return Scaffold(
      body: Stack(
        children: [
          // ---- Background Image ----
          AppImage(
            path: 'assets/images/auth_bg.png',
            width: double.infinity,
            height: 280.h,
            fit: BoxFit.cover,
          ),

          // ---- Purple overlay ----
          Container(
            width: double.infinity,
            height: 280.h,
            color: ConstColor.primaryColor.withAlpha(102),
          ),

          // ---- Bottom dark BG ----
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 500.h,
              color: ConstColor.primaryColor,
            ),
          ),

          // ---- White card ----
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 40.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ---- Logo ----
                  SvgPicture.asset(
                    'assets/icons/ic_logo.svg',
                    width: 48.w,
                    height: 48.h,
                  ),

                  SizedBox(height: 12.h),

                  // ---- Title ----
                  CustomText(
                    title: ConstString.verifyOtp,
                    textColor: ConstColor.black,
                    textSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),

                  SizedBox(height: 6.h),

                  // ---- Subtitle ----
                  CustomText(
                    title: ConstString.enterCodeSent,
                    textColor: ConstColor.grey,
                    textSize: 13.sp,
                    textAlign: TextAlign.center,
                    maxLine: 2,
                  ),

                  SizedBox(height: 24.h),

                  // ---- OTP Boxes ----
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                          (index) => _OtpBox(
                        controller: controller.otpControllers[index],
                        focusNode: controller.otpFocusNodes[index],
                        onChanged: (val) =>
                            controller.onOtpChanged(val, index),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ---- Code sent text ----
                  CustomText(
                    title: ConstString.codeHasBeenSent,
                    textColor: ConstColor.grey,
                    textSize: 13.sp,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),

                  SizedBox(height: 4.h),

                  // ---- Timer ----
                  Obx(
                        () => CustomText(
                      title: controller.formattedTimer,
                      textColor: ConstColor.primaryColor,
                      textSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      maxLine: 1,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ---- Verify Button ----
                  Obx(
                        () => CustomElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.verifyOtp,
                      height: 54,
                      top: 0,
                      buttonBorderRadius: 30,
                      gradient: const [
                        Color(0xFF7B5EA7),
                        Color(0xFF5B2D8E),
                      ],
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                          : CustomText(
                        title: ConstString.verify,
                        textColor: Colors.white,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // ---- Don't get OTP ----
                  CustomText(
                    title: ConstString.donTGetOtp,
                    textColor: ConstColor.black,
                    textSize: 13.sp,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),

                  SizedBox(height: 4.h),

                  // ---- Resend ----
                  Obx(
                        () => GestureDetector(
                      onTap: controller.canResend.value
                          ? controller.resendOtp
                          : null,
                      child: CustomText(
                        title: ConstString.resend,
                        textColor: controller.canResend.value
                            ? ConstColor.primaryColor
                            : ConstColor.grey,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // ---- Back to Sign Up ----
                  GestureDetector(
                    onTap: controller.goBack,
                    child: CustomText(
                      title: ConstString.backToSignUp,
                      textColor: ConstColor.black,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Single OTP Input Box ----
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.w,
      height: 60.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: ConstColor.black,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: ConstColor.grey,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: ConstColor.primaryColor,
              width: 1.5.w,
            ),
          ),
        ),
      ),
    );
  }
}