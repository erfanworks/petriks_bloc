import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';

// ─── ERROR FIXED: Changed the import path to match your controller exactly ───
import '../Controller/my_community_detail_controller.dart';
// ─────────────────────────────────────────────────────────────────────────────

class MyGroupCard extends StatelessWidget {
  final GroupItem item; // Now it takes the correct GroupItem from the correct file!
  final VoidCallback onTap;

  const MyGroupCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
            ),
            child: AppImage(
              path: item.image,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: item.name,
                        textColor: ConstColor.black,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      CustomText(
                        title:
                        "5:00 AM starts across the city. No excuses, just pavement and pace.",
                        textColor: ConstColor.textColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 3,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 14.sp,
                            color: ConstColor.primaryDeepColor,
                          ),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: '${item.memberCount} members',
                            textColor: ConstColor.textColor,
                            textSize: 14.sp,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      // border: Border.all(color: ConstColor.primaryColor),
                      color: ConstColor.primaryDeepColor.withAlpha(40),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: ConstString.viewGroup,
                      textColor: ConstColor.primaryColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}