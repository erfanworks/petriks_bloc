import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/phone_login_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhoneLoginController>();

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
              child: Form(
                key: controller.phoneFormKey,
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
                      title: ConstString.continueWithPhoneTitle,
                      textColor: ConstColor.black,
                      textSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      maxLine: 1,
                    ),

                    SizedBox(height: 6.h),

                    // ---- Subtitle ----
                    CustomText(
                      title: ConstString.noWorries,
                      textColor: ConstColor.grey,
                      textSize: 13.sp,
                      textAlign: TextAlign.center,
                      maxLine: 2,
                    ),

                    SizedBox(height: 20.h),

                    // ---- Phone Number Field ----
                    CustomTextFormField(
                      fromTitle: ConstString.phoneNumber,
                      hintText: CustomText(
                        title: ConstString.enterPhoneNumber,
                        textColor: ConstColor.grey,
                        textSize: 13.sp,
                        maxLine: 1,
                      ),
                      textController: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      numeric: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SvgPicture.asset(
                          'assets/icons/ic_phone.svg',
                          width: 20.w,
                          height: 20.h,
                          colorFilter: const ColorFilter.mode(
                            ConstColor.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      borderRadius: 30,
                      backgroundColor: ConstColor.grey,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 8.h),

                    // ---- Send OTP Button ----
                    Obx(
                          () => CustomElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.sendOtp,
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
                          title: ConstString.sendOtp,
                          textColor: Colors.white,
                          textSize: 15.sp,
                          fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }
}