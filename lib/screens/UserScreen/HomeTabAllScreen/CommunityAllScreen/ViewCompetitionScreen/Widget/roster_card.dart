import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/view_competition_controller.dart';

class RosterCard extends StatelessWidget {
  final RosterGroup group;
  final String? memberLabel;
  // ── Selection params — optional, default no selection UI ──
  final bool isSelected;
  final VoidCallback? onTap;

  const RosterCard({
    super.key,
    required this.group,
    this.memberLabel,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: ConstColor.primaryColor.withAlpha(40), blurRadius: 10, spreadRadius: 1)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: AppImage(path: group.image, width: 50.w, height: 50.h, fit: BoxFit.cover),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title: group.name, textColor: ConstColor.black, textSize: 14.sp, fontWeight: FontWeight.w600, maxLine: 1),
                      SizedBox(height: 2.h),
                      CustomText(title: memberLabel ?? group.memberCount, textColor: ConstColor.grey, textSize: 12.sp, maxLine: 1),
                    ],
                  ),
                ),

                // ── Selected check badge ──
                if (isSelected)
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_rounded, color: Colors.white, size: 14.sp),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            _SmallAvatarStack(),
          ],
        ),
      ),
    );
  }
}

class _SmallAvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.w,
      height: 26.h,
      child: Stack(
        children: [
          Positioned(left: 0,     child: _CircleAvatar(path: 'assets/images/onboarding5_img.jpg')),
          Positioned(left: 15.w,  child: _CircleAvatar(path: 'assets/images/onboarding3_img.jpg')),
          Positioned(
            left: 30.w,
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ConstColor.primaryColor,
                border: Border.all(color: Colors.white, width: 1.5.w),
              ),
              child: Center(
                child: CustomText(title: '+1', textColor: Colors.white, textSize: 9.sp, fontWeight: FontWeight.w700, maxLine: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  final String path;
  const _CircleAvatar({required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5.w)),
      child: ClipOval(child: AppImage(path: path, width: 26.w, height: 26.h, fit: BoxFit.cover)),
    );
  }
}