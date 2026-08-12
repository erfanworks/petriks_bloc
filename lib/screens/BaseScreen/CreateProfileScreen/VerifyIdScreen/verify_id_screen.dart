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
                    _InfoCard(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/lock_icon.svg',
                            width: 15.r,
                            height: 20.r,
                            colorFilter: const ColorFilter.mode(
                                Color(0xFF6C5CE7), BlendMode.srcIn),
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            title:
                            ConstString.yourIdIsSecurely,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            textColor: ConstColor.textColor,
                            textAlign: TextAlign.center,
                            maxLine: 2,
                          ),
                        ],
                      ),
                    ),

                    // SizedBox(height: 14.h),

                    // ── Upload card ──
                    // const UploadIdCard(),
                    SizedBox(height: 14.h),
                    CustomElevatedButton(
                      top: 0,
                      height: 48,
                      elevation: 0,
                      onPressed: c.onContinueToVerification,
                      buttonBorderRadius: 30,
                      isOutLined: true,
                      outLineColour: ConstColor.primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: ConstString.continueToVerification,
                            textSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.primaryColor,
                          ),
                          SizedBox(width: 8.w),
                          const Icon(Icons.verified_outlined)
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // ── Continue ──
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Obx(
                () => CustomElevatedButton(
                  top: 0,
                  onPressed: c.isLoading.value ? null : c.onVerifyIdContinue,
                  gradient: [
                    ConstColor.primaryDeepColor,
                    ConstColor.primaryColor,
                  ],
                  buttonBorderRadius: 30,
                  child: c.isLoading.value
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : CustomText(
                          title: ConstString.continueA,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                        ),
                ),
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