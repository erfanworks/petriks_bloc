import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';

void showCreateOptionsSheet() {
  Get.bottomSheet(
    const _CreateOptionsSheet(),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: true,
  );
}

class _CreateOptionsSheet extends StatelessWidget {
  const _CreateOptionsSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ConstColor.borderColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          CustomText(
            title: ConstString.whatWouldYouLikeToCreate,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
          SizedBox(height: 20.h),

          Row(
            children: [
              Expanded(
                child: _OptionCard(
                  icon: 'assets/icons/create_plan_icon.svg',
                  label: ConstString.createPlan,
                  bgColor: ConstColor.primaryColor.withAlpha(20),
                  iconColor: ConstColor.primaryColor,
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.createPlanScreen);
                  },
                ),
              ),
              SizedBox(width: 14.w),

              // Create Post
              Expanded(
                child: _OptionCard(
                  icon: 'assets/icons/create_post icon.svg',
                  label: ConstString.createPost,
                  bgColor: const Color(0xFFFFF3E0),
                  iconColor: const Color(0xFFFF9800),
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.createPostScreen);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: ConstColor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 26.w,
                  height: 26.h,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            CustomText(
              title: label,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

