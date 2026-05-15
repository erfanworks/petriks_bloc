import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Widget/text/custom_text.dart';
import '../../../constant/const_color.dart';
import '../../../constant/const_string.dart';
import '../../../widget/AppImage/app_image.dart';
import '../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());
    return Scaffold(
      backgroundColor: ConstColor.primaryColor,
      body: Column(
        children: [
          Expanded(flex: 6, child: _MapSection(controller: controller)),
          Expanded(flex: 5, child: _BottomCard(controller: controller)),
        ],
      ),
    );
  }
}

class _MapSection extends StatelessWidget {
  const _MapSection({required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title: ConstString.welcomeTo,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white.withAlpha(200),
                    maxLine: 1,
                  ),
                  CustomText(
                    title: ConstString.appName,
                    textSize: 32.sp,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.white,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        title: ConstString.yourCommunityStartsHere,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.white,
                        maxLine: 1,
                      ),
                      SizedBox(width: 6.w),
                      Text('👋', style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 160.h,
            left: 0,
            right: 0,
            child: Center(
              child: _DashedCircle(
                radius: 130.r,
                color: Colors.white.withAlpha(150),
              ),
            ),
          ),

          Positioned(
            top: 205.h,
            left: 0,
            right: 0,
            child: Center(
              child: _DashedCircle(
                radius: 85.r,
                color: Colors.white.withAlpha(150),
              ),
            ),
          ),

          Positioned(
            top: 255.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(10),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(60), width: 1.5),
                ),
                child: Center(
                  child: Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        width: 28.w,
                        height: 28.h,
                        "assets/icons/onboarding_chat_icon.svg",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 248.h,
            right: 138,
            child: Icon(Icons.location_on, color: Colors.white, size: 23.sp),
          ),

          Positioned(
            top: 310.h,
            right: 90.w,
            child: Icon(
              Icons.location_on,
              color: Colors.white.withAlpha(120),
              size: 16.sp,
            ),
          ),

          Positioned(
            top: 228.h,
            right: 36.w,
            child: _AvatarBubble(
              imagePath: 'assets/images/splash_5.jpg',
              size: 56,
            ),
          ),

          Positioned(
            top: 250.h,
            left: 72.w,
            child: _AvatarBubble(
              imagePath: 'assets/images/splash_4.jpg',
              size: 52,
            ),
          ),

          Positioned(
            bottom: 25.h,
            left: 170.w,
            child: _AvatarBubble(
              imagePath: 'assets/images/splash_6.jpg',
              size: 50,
            ),
          ),

          Positioned(top: 155.h, left: 16.w, child: _GroupCard()),

          Positioned(
            top: 168.h,
            right: 16.w,
            child: _LocationCard(label: ConstString.buildYourCommunity),
          ),

          Positioned(bottom: 50.h, left: 12.w, child: _CompetitionCard()),

          Positioned(bottom: 10.h, right: 16.w, child: _OneTOOneCard()),
        ],
      ),
    );
  }
}

class _DashedCircle extends StatelessWidget {
  final double radius;
  final Color color;

  const _DashedCircle({required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: _DashedCirclePainter(color: color),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;

  const _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const dashCount = 28;
    const dashAngle = 0.08;
    const gapAngle = (3.14159 * 2 / dashCount) - dashAngle;
    double angle = 0;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        angle,
        dashAngle,
        false,
        paint,
      );
      angle += dashAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter old) => false;
}

class _AvatarBubble extends StatelessWidget {
  final String imagePath;
  final double size;

  const _AvatarBubble({required this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withAlpha(180), width: 2.5),
      ),
      child: ClipOval(
        child: AppImage(
          path: imagePath,
          fit: BoxFit.cover,
          width: size.r,
          height: size.r,
        ),
      ),
    );
  }
}

class _SmallAvatar extends StatelessWidget {
  final String path;
  final double left;

  const _SmallAvatar({required this.path, required this.left});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: ClipOval(
          child: AppImage(
            path: path,
            fit: BoxFit.cover,
            width: 28.r,
            height: 28.r,
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const _LocationCard({required this.label, this.icon = Icons.groups});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24.sp),
              SizedBox(width: 4.w),
              CustomText(
                title: label,
                textSize: 11.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
                maxLine: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _OneTOOneCard extends StatelessWidget {
//   const _OneTOOneCard();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
//       decoration: BoxDecoration(
//         color: Colors.white.withAlpha(30),
//         borderRadius: BorderRadius.circular(14.r),
//         border: Border.all(color: Colors.white.withAlpha(60), width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
//             decoration: BoxDecoration(
//               color: const Color(0xFF34D399),
//               borderRadius: BorderRadius.circular(6.r),
//             ),
//             child: CustomText(
//               title: ConstString.oneToOne,
//               textSize: 9.sp,
//               fontWeight: FontWeight.w700,
//               textColor: const Color(0xFF022C22),
//               maxLine: 1,
//             ),
//           ),
//           SizedBox(height: 6.h),
//           Row(
//             children: [
//               SizedBox(
//                 width: 50.w,
//                 height: 28.r,
//                 child: Stack(
//                   children: [
//                     _SmallAvatar(path: 'assets/images/splash_7.jpg', left: 0),
//                     _SmallAvatar(path: 'assets/images/splash_8.jpg', left: 18),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 6.w),
//               Icon(
//                 Icons.swap_horiz_rounded,
//                 color: Colors.white.withAlpha(150),
//                 size: 20.sp,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class _BottomCard extends StatelessWidget {
  const _BottomCard({required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(28.w, 24.h, 28.w, 24.h),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_logo.png",
              width: 60.r,
              height: 60.r,
            ),
            SizedBox(height: 12.h),
            CustomText(
              title: ConstString.onboardingHeadline,
              textSize: 30.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.black,
              textAlign: TextAlign.center,
              maxLine: 3,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 12.h),
            CustomText(
              title: ConstString.onboardingSubHeadline,
              textSize: 16.sp,
              fontWeight: FontWeight.w400,
              textColor: ConstColor.textColor,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              gradient: const [
                ConstColor.primaryDeepColor,
                ConstColor.primaryColor,
              ],
              top: 0,
              onPressed: controller.onGetStarted,
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.getStarted,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: bottomPadding),
          ],
        ),
      ),
    );
  }
}

// ── Replace _GroupCard with this ──
class _GroupCard extends StatelessWidget {
  const _GroupCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GROUP label row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.groups_rounded, color: Colors.white, size: 24.sp),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: ConstString.group,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    maxLine: 1,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // Stacked avatars
              SizedBox(
                height: 30.r,
                width: 92.w,
                child: Stack(
                  children: [
                    _SmallAvatar(path: 'assets/images/splash_1.jpg', left: 0),
                    _SmallAvatar(path: 'assets/images/splash_2.jpg', left: 20),
                    _SmallAvatar(path: 'assets/images/splash_3.jpg', left: 40),
                    Positioned(
                      left: 60,
                      child: Container(
                        width: 30.r,
                        height: 30.r,
                        decoration: BoxDecoration(
                          color: ConstColor.primaryDeepColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Center(
                          child: CustomText(
                            title: '+5',
                            textSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            maxLine: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompetitionCard extends StatelessWidget {
  const _CompetitionCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: ConstString.competition,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    maxLine: 1,
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              CustomText(
                title: 'Enter challenges &\nclimb leaderboards',
                textSize: 11.sp,
                fontWeight: FontWeight.w400,
                textColor: Colors.white.withAlpha(200),
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Replace _OneTOOneCard with this ──
class _OneTOOneCard extends StatelessWidget {
  const _OneTOOneCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withAlpha(80), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1-TO-1 badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: ConstColor.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: CustomText(
                  title: ConstString.oneToOne,
                  textSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.white,
                  maxLine: 1,
                ),
              ),
              SizedBox(height: 6.h),
              CustomText(
                title: 'Enter challenges &\nclimb leaderboards',
                textSize: 11.sp,
                fontWeight: FontWeight.w400,
                textColor: Colors.white.withAlpha(200),
                maxLine: 2,
              ),
              SizedBox(height: 8.h),
              // Stacked avatars + swap icon
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 52.w,
                    height: 28.r,
                    child: Stack(
                      children: [
                        _SmallAvatar(
                          path: 'assets/images/splash_7.jpg',
                          left: 0,
                        ),
                        _SmallAvatar(
                          path: 'assets/images/splash_8.jpg',
                          left: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.swap_horiz_rounded,
                    color: Colors.white.withAlpha(180),
                    size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
