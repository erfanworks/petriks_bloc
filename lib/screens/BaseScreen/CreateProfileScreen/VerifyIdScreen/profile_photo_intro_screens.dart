import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'Add a profile photo',
                    textSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: 'Profiles with photos feel more trustworthy',
                    textSize: 13.sp,
                    textColor: const Color(0xFF6B6B80),
                    maxLine: 2,
                  ),
                ],
              ),
            ),

            // ── Camera selfie circle ──
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: open camera
                  },
                  child: Container(
                    width: 200.r,
                    height: 200.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withAlpha(20),
                          blurRadius: 30.r,
                          spreadRadius: 10.r,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C5CE7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/ic_camera.svg',
                              width: 28.r,
                              height: 28.r,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomText(
                          title: 'Take a Selfie',
                          textSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFF1A1A2E),
                          maxLine: 1,
                        ),
                        SizedBox(height: 2.h),
                        CustomText(
                          title: 'Use your camera now',
                          textSize: 12.sp,
                          textColor: const Color(0xFF6B6B80),
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Upload from gallery ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: () {
                  // TODO: gallery picker
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
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
                            'assets/icons/ic_gallery.svg',
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
                            title: 'Upload from Gallery',
                            textSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            textColor: const Color(0xFF1A1A2E),
                            maxLine: 1,
                          ),
                          SizedBox(height: 2.h),
                          CustomText(
                            title: 'Pick from your photolibrary',
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
            ),

            // ── Continue (disabled state — grey until photo selected) ──
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CustomElevatedButton(
                top: 0,
                onPressed: () => Get.toNamed('/add-intro'),
                color: const Color(0xFF9E9E9E),
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

// ── Add Short Intro Screen ──
class AddIntroScreen extends StatelessWidget {
  const AddIntroScreen({super.key});

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: 'Add a short intro',
                        textSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        textColor: const Color(0xFF1A1A2E),
                        maxLine: 1,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: 'Say hello and share the kinds of plans you enjoy',
                        textSize: 13.sp,
                        textColor: const Color(0xFF6B6B80),
                        maxLine: 2,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/home'),
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

            // ── Video preview area ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Camera preview placeholder
                      Container(color: Colors.black87),

                      // REC badge
                      Positioned(
                        top: 16.h,
                        left: 16.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7.r,
                                height: 7.r,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(width: 5.w),
                              CustomText(
                                title: 'REC',
                                textSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.white,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Timer
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: CustomText(
                          title: '00:08 / 00:15',
                          textSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.white,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // ── Camera controls ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flip camera
                  GestureDetector(
                    onTap: () {
                      // TODO: flip camera
                    },
                    child: Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFFE0DFF0), width: 1.5),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/ic_flip_camera.svg',
                          width: 22.r,
                          height: 22.r,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF6B6B80), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 24.w),

                  // Record button
                  GestureDetector(
                    onTap: () {
                      // TODO: start/stop recording
                    },
                    child: Container(
                      width: 64.r,
                      height: 64.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF6C5CE7), width: 2.5),
                      ),
                      child: Center(
                        child: Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Confirm button ──
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CustomElevatedButton(
                top: 0,
                onPressed: () => Get.toNamed('/home'),
                color: const Color(0xFF6C5CE7),
                buttonBorderRadius: 30,
                child: CustomText(
                  title: 'Confirm',
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