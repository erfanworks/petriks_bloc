import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/create_profile_controller.dart';

class StepShell extends StatelessWidget {
  const StepShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onContinue,
    this.continueEnabled = true,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onContinue;
  final bool continueEnabled;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Scrollable area: title + subtitle + content ──
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                CustomText(
                  title: title,
                  textSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.textColor,
                  maxLine: 3,
                ),
                SizedBox(height: 6.h),
                // Subtitle
                CustomText(
                  title: subtitle,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.silverGray20,
                  maxLine: 3,
                ),
                SizedBox(height: 20.h),
                // Step content
                child,
              ],
            ),
          ),
        ),

        // ── Continue button (fixed bottom) ──
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: CustomElevatedButton(
            top: 0,
            onPressed: continueEnabled
                ? (onContinue ?? controller.nextStep)
                : null,
            color: continueEnabled
                ? ConstColor.primaryColor
                : ConstColor.primaryDeepColor,
            buttonBorderRadius: 30,
            child: CustomText(
              title: ConstString.continueA,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// Reusable single-select card (Steps 4, 5, 6, 7)
class SelectableOptionCard extends StatelessWidget {
  const SelectableOptionCard({
    super.key,
    required this.label,
    required this.description,
    required this.iconWidget,
    required this.isSelected,
    required this.onTap,
    this.showSelectedBadge = false,
  });

  final String label;
  final String description;
  final Widget iconWidget;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showSelectedBadge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6C5CE7).withAlpha(20)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6C5CE7)
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // Icon circle
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6C5CE7)
                        : const Color(0xFFF0EEF9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: iconWidget),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: label,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        textColor: const Color(0xFF1A1A2E),
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        title: description,
                        textSize: 12.sp,
                        textColor: const Color(0xFF6B6B80),
                        maxLine: 3,
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6C5CE7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 14.r),
                  ),
              ],
            ),
          ),
          // 'SELECTED' badge on top-right corner
          if (isSelected && showSelectedBadge)
            Positioned(
              top: -1,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                child: CustomText(
                  title: ConstString.selected,
                  textSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  maxLine: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}