import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          Expanded(
            flex: 6,
            child: _MapSection(controller: controller),
          ),

          Expanded(
            flex: 5,
            child: _BottomCard(controller: controller),
          ),
        ],
      ),
    );
  }
}


// Map Section  (purple background + avatars)
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
          // Scattered location pins (SVG)
          ..._buildLocationPins(),

          // Scattered dot decorations
          ..._buildDots(),

          // Avatar bubbles positioned like the design
          _AvatarBubble(
            imagePath: "assets/images/onboarding1_img.jpg",
            size: 72,
            left: 40,
            top: 60,
          ),
          _AvatarBubble(
            imagePath: "assets/images/onboarding2_img.jpg",
            size: 90,
            left: 0,
            right: 0,
            top: 180,
            centerHorizontal: true,
          ),
          _AvatarBubble(
            imagePath: "assets/images/onboarding3_img.jpg",
            size: 66,
            right: 30,
            top: 95,
          ),
          _AvatarBubble(
            imagePath: "assets/images/onboarding4_img.jpg",
            size: 52,
            left: 75,
            bottom: 120,
          ),
          _AvatarBubble(
            imagePath: "assets/images/onboarding5_img.jpg",
            size: 58,
            right: 95,
            bottom: 50,
          ),
        ],
      ),
    );
  }

  // Build scattered location pin icons
  List<Widget> _buildLocationPins() {
    final pins = [
      _PinPosition(left: 150, top: 110),
      _PinPosition(right: 130, top: 180),
      _PinPosition(left: 50, top: 240),
      _PinPosition(right: 50, bottom: 130),
    ];

    return pins.map((p) {
      return Positioned(
        left: p.left,
        right: p.right,
        top: p.top,
        bottom: p.bottom,
        child: SvgPicture.asset(
          "assets/icons/location_icon.svg",
          width: 18.w,
          height: 18.h,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      );
    }).toList();
  }

  // Build scattered white dot decorations
  List<Widget> _buildDots() {
    final dots = [
      _PinPosition(right: 110, top: 280),
      _PinPosition(left: 190, bottom: 100),
      _PinPosition(left: 130, bottom: 240),
      _PinPosition(left: 80, bottom: 50),
    ];

    return dots.map((d) {
      return Positioned(
        left: d.left,
        right: d.right,
        top: d.top,
        bottom: d.bottom,
        child: Container(
          width: 6.r,
          height: 6.r,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );
    }).toList();
  }
}

// Avatar Bubble Widget
class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({
    required this.imagePath,
    required this.size,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.centerHorizontal = false,
  });

  final String imagePath;
  final double size;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final bool centerHorizontal;

  @override
  Widget build(BuildContext context) {
    final Widget bubble = Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ConstColor.primaryColor.withAlpha(120), width: 3.r),
        color: Colors.white,
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

    if (centerHorizontal) {
      return Positioned(
        top: top,
        bottom: bottom,
        left: 0,
        right: 0,
        child: Center(child: bubble),
      );
    }

    return Positioned(
      left: left?.w,
      right: right?.w,
      top: top?.h,
      bottom: bottom?.h,
      child: bubble,
    );
  }
}

// Bottom White Card
class _BottomCard extends StatelessWidget {
  const _BottomCard({required this.controller});

  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/app_logo.png",
              width: 60.r,
              height: 60.r,
          ),

          SizedBox(height: 16.h),

          // Headline text
          CustomText(
            title: ConstString.onboardingHeadline,
            textSize: 30.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            textAlign: TextAlign.center,
            maxLine: 3,
          ),

          SizedBox(height: 12.h),

          // Sub-headline text
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
              Color(0xFF5341CD),
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
        ],
      ),
    );
  }
}

// Helper model for pin/dot positions
class _PinPosition {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;

  _PinPosition({this.left, this.right, this.top, this.bottom});
}