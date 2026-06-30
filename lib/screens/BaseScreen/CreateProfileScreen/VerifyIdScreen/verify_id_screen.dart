import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Widget/upload_id_card.dart';

class VerifyIdScreen extends StatelessWidget {
  const VerifyIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => Get.toNamed(AppRoutes.subscriptionScreen, arguments: {'showFreePlan': true}),
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

                    SizedBox(height: 14.h),

                    // ── Upload card ──
                    UploadIdCard(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(AppRoutes.profilePhotoScreen);
                    //   },
                    //   child: _InfoCard(
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           width: 48.r,
                    //           height: 48.r,
                    //           decoration: BoxDecoration(
                    //             color: const Color(0xFF6C5CE7).withAlpha(30),
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: Center(
                    //             child: SvgPicture.asset(
                    //               'assets/icons/gellary_icon.svg',
                    //               width: 22.r,
                    //               height: 22.r,
                    //               colorFilter: const ColorFilter.mode(
                    //                   ConstColor.primaryColor, BlendMode.srcIn),
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 14.w),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             CustomText(
                    //               title: ConstString.uploadIdFor,
                    //               textSize: 16.sp,
                    //               fontWeight: FontWeight.w700,
                    //               textColor: const Color(0xFF1A1A2E),
                    //               maxLine: 1,
                    //               fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    //             ),
                    //             SizedBox(height: 2.h),
                    //             CustomText(
                    //               title: 'PDF, PNG, Zip',
                    //               textSize: 14.sp,
                    //               fontWeight: FontWeight.w400,
                    //               textColor: ConstColor.grey,
                    //               maxLine: 1,
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // ── Continue ──
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CustomElevatedButton(
                top: 0,
                onPressed: () => Get.toNamed(AppRoutes.profilePhotoScreen),
                gradient: [
                  ConstColor.primaryDeepColor,
                  ConstColor.primaryColor,
                ],
                buttonBorderRadius: 30,
                child: CustomText(
                  title: ConstString.continueA,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white,
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