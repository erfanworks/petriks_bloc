import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      body: Stack(
        children: [
          // ---- Background Image (top half) ----
          AppImage(
            path: 'assets/images/auth_bg.png',
            width: double.infinity,
            height: 380.h,
            fit: BoxFit.cover,
          ),

          // ---- Purple overlay on image ----
          Container(
            width: double.infinity,
            height: 380.h,
            color: ConstColor.primaryColor.withAlpha(102),
          ),

          // ---- Full page dark bottom background ----
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 500.h,
              color: ConstColor.black,
            ),
          ),

          // ---- Content ----
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 100.h),

                // ---- App Logo ----
                SvgPicture.asset(
                  'assets/icons/ic_logo.svg',
                  width: 48.w,
                  height: 48.h,
                ),

                SizedBox(height: 16.h),

                // ---- Title ----
                CustomText(
                  title: ConstString.signInToYour,
                  textColor: Colors.white,
                  textSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                CustomText(
                  title: ConstString.account,
                  textColor: Colors.white,
                  textSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),

                SizedBox(height: 8.h),

                // ---- Subtitle ----
                CustomText(
                  title: ConstString.enterEmailPassword,
                  textColor: Colors.white,
                  textSize: 13.sp,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),

                SizedBox(height: 32.h),

                // ---- Buttons ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Google Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithGoogle,
                        color: Colors.white,
                        height: 54,
                        top: 0,
                        bottom: 12,
                        buttonBorderRadius: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_google.svg',
                              width: 22.w,
                              height: 22.h,
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              title: ConstString.continueWithGoogle,
                              textColor: ConstColor.black,
                              textSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),

                      // Facebook Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithFacebook,
                        color: Colors.white,
                        height: 54,
                        top: 0,
                        bottom: 12,
                        buttonBorderRadius: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_facebook.svg',
                              width: 22.w,
                              height: 22.h,
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              title: ConstString.continueWithFacebook,
                              textColor: ConstColor.black,
                              textSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),

                      // Phone Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithPhone,
                        color: Colors.white,
                        height: 54,
                        top: 0,
                        bottom: 0,
                        buttonBorderRadius: 30,
                        child: CustomText(
                          title: ConstString.continueWithPhone,
                          textColor: ConstColor.black,
                          textSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // ---- Terms & Privacy ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                      ),
                      children: [
                        TextSpan(text: ConstString.byContinuing),
                        TextSpan(
                          text: ConstString.termsConditions,
                          style: TextStyle(
                            color: ConstColor.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ConstColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.openTerms,
                        ),
                        TextSpan(text: ConstString.andHaveRead),
                        TextSpan(
                          text: ConstString.privacyPolicy,
                          style: TextStyle(
                            color: ConstColor.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ConstColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.openPrivacyPolicy,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // ---- Sign Up Row ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: ConstString.donTHaveAccount,
                      textColor: Colors.white,
                      textSize: 13.sp,
                      maxLine: 1,
                    ),
                    GestureDetector(
                      onTap: controller.goToSignUp,
                      child: CustomText(
                        title: ConstString.signUp,
                        textColor: ConstColor.primaryColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}