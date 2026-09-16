import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/verify_id_controller.dart';
import 'Widget/upload_id_card.dart';

class VerifyIdScreen extends StatelessWidget {
  const VerifyIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(VerifyIdController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: ConstString.verifyYourId,
                    textSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 2,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  GestureDetector(
                    onTap: c.onSkip,
                    child: CustomText(
                      title: ConstString.skip,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.primaryColor,
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                ],
              ),
            ),

            CustomText(
              left: 20,
              title: ConstString.unlockFullAccess,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              textColor: const Color(0xFF6B6B80),
              maxLine: 2,
            ),

            SizedBox(height: 24.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: ConstString.whyVerify,
                            textSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.textColor,
                            maxLine: 1,
                            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          ),
                          SizedBox(height: 12.h),
                          ...[
                            ConstString.accessAllPlan,
                            ConstString.higherTrustWithOthers,
                            ConstString.betterVisibility,
                          ].map(
                                (text) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: ConstColor.primaryColor,
                                      size: 18.r),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    title: text,
                                    textSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    textColor: ConstColor.textColor,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // ── Secure card ──
                    // ── Handled securely card ──
                    _InfoCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44.r,
                            height: 44.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EFFF),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/security_verification.png',
                                width: 22.r,
                                height: 22.r,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: "Handled securely by our verification partner",
                                  textSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ConstColor.black,
                                  maxLine: 2,
                                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                                ),
                                SizedBox(height: 6.h),
                                CustomText(
                                  title: "Your ID verification is processed securely by a trusted third-party provider. Your information is encrypted and used only for verification.",
                                  textSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  textColor: const Color(0xFF6B6B80),
                                  maxLine: 5,
                                ),
                                SizedBox(height: 16.h),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0EFFF),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(color: ConstColor.primaryColor.withAlpha(30))
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.lock_outline, size: 12.r, color: ConstColor.primaryColor),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        title: "Secure • Third-party verified",
                                        textSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        textColor: ConstColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Footer Buttons ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    top: 0,
                    onPressed: c.onContinueToVerification,
                    gradient: [
                      ConstColor.primaryDeepColor,
                      ConstColor.primaryColor,
                    ],
                    buttonBorderRadius: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          title: ConstString.continueToVerification,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18.sp),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: c.onSkip,
                    child: CustomText(
                      title: "Continue without verifying",
                      textSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}