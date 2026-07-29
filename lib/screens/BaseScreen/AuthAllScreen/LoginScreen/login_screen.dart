import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

          // ---- Content ----
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 160.h),

                // ---- App Logo ----
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 50.r,
                  height: 50.r,
                  color: ConstColor.white,
                ),

                SizedBox(height: 16.h),

                // ---- Title ----
                CustomText(
                  title: ConstString.signInToYour,
                  textColor: Colors.white,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                CustomText(
                  title: ConstString.account,
                  textColor: Colors.white,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),

                SizedBox(height: 8.h),

                // ---- Subtitle ----
                CustomText(
                  title: ConstString.chooseASignInMethod,
                  textColor: Colors.white,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),

                SizedBox(height: 12.h),

                // ---- Buttons ----
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Google Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithGoogle,
                        color: Colors.white,
                        top: 0,
                        bottom: 12,
                        buttonBorderRadius: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                "assets/images/google_icon.png",
                                width: 24.r,
                                height: 24.r,
                              ),
                            ),
                            CustomText(
                              title: ConstString.continueWithGoogle,
                              textColor: ConstColor.black,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                            ),
                          ],
                        ),
                      ),

                      // Facebook Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithFacebook,
                        color: Colors.white,
                        top: 0,
                        bottom: 12,
                        buttonBorderRadius: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                "assets/images/facebook_icon.png",
                                width: 24.r,
                                height: 24.r,
                              ),
                            ),
                            CustomText(
                              title: ConstString.continueWithFacebook,
                              textColor: ConstColor.black,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                            ),
                          ],
                        ),
                      ),

                      // Phone Button
                      CustomElevatedButton(
                        onPressed: controller.continueWithPhone,
                        color: Colors.white,
                        top: 0,
                        bottom: 0,
                        buttonBorderRadius: 30,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                "assets/images/phone_icon.png",
                                width: 19.r,
                                height: 19.r,
                              ),
                            ),
                            CustomText(
                              title: ConstString.continueWithPhone,
                              textColor: ConstColor.black,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                              fontFamily: GoogleFonts.montserrat().fontFamily,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      children: [
                        TextSpan(text: ConstString.byContinuing),
                        TextSpan(
                          text: ConstString.termsConditions,
                          style: TextStyle(
                            color: ConstColor.yellow,
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
                            color: ConstColor.yellow,
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

                // // ---- Sign Up Row ----
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomText(
                //       title: ConstString.donTHaveAccount,
                //       textColor: Colors.white,
                //       fontWeight: FontWeight.w400,
                //       textSize: 12.sp,
                //       maxLine: 1,
                //       fontFamily: GoogleFonts.montserrat().fontFamily,
                //     ),
                //     GestureDetector(
                //       onTap: controller.goToSignUp,
                //       child: CustomText(
                //         title: ConstString.signUp,
                //         textColor: ConstColor.yellow,
                //         textSize: 13.sp,
                //         fontWeight: FontWeight.w600,
                //         maxLine: 1,
                //         fontFamily: GoogleFonts.montserrat().fontFamily,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
