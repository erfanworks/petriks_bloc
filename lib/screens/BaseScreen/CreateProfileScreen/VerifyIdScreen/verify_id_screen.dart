import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

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
                    title: 'Verify your ID (optional)',
                    textSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 2,
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/profile-photo'),
                    child: CustomText(
                      title: 'Skip',
                      textSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      textColor: const Color(0xFF6C5CE7),
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
            ),

            CustomText(
              left: 20,
              title: 'Unlock full access and build more trust',
              textSize: 13.sp,
              textColor: const Color(0xFF6B6B80),
              maxLine: 2,
            ),

            SizedBox(height: 24.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // ── Why verify card ──
                    _InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: 'Why verify?',
                            textSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            textColor: const Color(0xFF1A1A2E),
                            maxLine: 1,
                          ),
                          SizedBox(height: 12.h),
                          ...[
                            'Access all plans and features',
                            'Higher trust with others',
                            'Better visibility in suggestions',
                          ].map(
                                (text) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle_outline,
                                      color: const Color(0xFF6C5CE7),
                                      size: 18.r),
                                  SizedBox(width: 10.w),
                                  CustomText(
                                    title: text,
                                    textSize: 13.sp,
                                    textColor: const Color(0xFF1A1A2E),
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
                            'assets/icons/ic_lock.svg',
                            width: 36.r,
                            height: 36.r,
                            colorFilter: const ColorFilter.mode(
                                Color(0xFF6C5CE7), BlendMode.srcIn),
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            title:
                            'Your ID is securely processed and never shared',
                            textSize: 13.sp,
                            textColor: const Color(0xFF6B6B80),
                            textAlign: TextAlign.center,
                            maxLine: 3,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // ── Upload card ──
                    GestureDetector(
                      onTap: () {
                        // TODO: file picker
                      },
                      child: _InfoCard(
                        child: Row(
                          children: [
                            Container(
                              width: 48.r,
                              height: 48.r,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/ic_upload.svg',
                                  width: 22.r,
                                  height: 22.r,
                                  colorFilter: const ColorFilter.mode(
                                      Color(0xFF6C5CE7), BlendMode.srcIn),
                                ),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: 'Upload id for verification',
                                  textSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: const Color(0xFF1A1A2E),
                                  maxLine: 1,
                                ),
                                SizedBox(height: 2.h),
                                CustomText(
                                  title: 'PDF, PNG, Zip',
                                  textSize: 12.sp,
                                  textColor: const Color(0xFF6B6B80),
                                  maxLine: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
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
              child: CustomElevatedButton(
                top: 0,
                onPressed: () => Get.toNamed('/profile-photo'),
                color: const Color(0xFF6C5CE7),
                buttonBorderRadius: 30,
                child: CustomText(
                  title: 'Continue',
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