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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Background Image (unchanged) ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppImage(
              path: 'assets/images/auth_img.jpg',
              width: double.infinity,
              height: 410.h,
              fit: BoxFit.cover,
            ),
          ),

          // ── Gradient Overlay (unchanged) ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.0, 0.19, 0.50, 1.0],
                  colors: [
                    Color(0xBB000000),
                    Color(0x66000000),
                    Color(0x1A6C5CE7),
                    Color(0xFF211A58),
                    Color(0xFF211A58),
                  ],
                ),
              ),
            ),
          ),

          // ── Card — always centered, keyboard aware ──
          Positioned.fill(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: keyboardHeight > 0 ? keyboardHeight + 16.h : 0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ---- Logo ----
                        Image.asset(
                          "assets/images/app_logo.png",
                          width: 50.r,
                          height: 50.r,
                        ),

                        SizedBox(height: 12.h),

                        // ---- Title ----
                        CustomText(
                          title: ConstString.verifyOtp,
                          textColor: ConstColor.black,
                          textSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                          maxLine: 1,
                        ),

                        SizedBox(height: 6.h),

                        // ---- Subtitle ----
                        CustomText(
                          title: ConstString.enterCodeSent,
                          textColor: ConstColor.grey,
                          textSize: 15.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          maxLine: 2,
                        ),

                        SizedBox(height: 20.h),

                        // ---- OTP Boxes ----
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                                (index) => _OtpBox(
                              controller: controller.otpControllers[index],
                              focusNode: controller.otpFocusNodes[index],
                              onChanged: (val) => controller.onOtpChanged(val, index),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        // ---- Code sent text ----
                        CustomText(
                          title: ConstString.codeHasBeenSent,
                          textColor: ConstColor.grey,
                          textSize: 14.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),

                        SizedBox(height: 4.h),

                        // ---- Timer ----
                        Obx(
                              () => CustomText(
                            title: controller.formattedTimer,
                            textColor: ConstColor.primaryColor,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w500,
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
                            top: 0,
                            buttonBorderRadius: 30,
                            gradient: const [
                              ConstColor.primaryDeepColor,
                              ConstColor.primaryColor,
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
                          textSize: 14.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),

                        SizedBox(height: 14.h),

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
                              textSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              maxLine: 1,
                              decorationStyle: TextDecoration.underline
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // ---- Back to Sign Up ----
                        GestureDetector(
                          onTap: controller.goBack,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_back),
                              SizedBox(width: 4.w),
                              CustomText(
                                title: ConstString.backToSignUp,
                                textColor: ConstColor.black,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
      width: 68.w,
      height: 64.h,
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
          fillColor: ConstColor.boxColor,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: ConstColor.borderColor,
              width: 1.5,
            ),
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