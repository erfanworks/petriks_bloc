import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/my_community_controller.dart';

class MyCommunityCard extends StatelessWidget {
  final MyCommunityModel item;
  final VoidCallback onTap;

  const MyCommunityCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isOwner = item.role.toLowerCase() == 'owner';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Image & Top Tag ----
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: AppImage(
                    path: item.image,
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: ConstColor.boxColor, // Semi-transparent white
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: item.tag,
                      textColor: ConstColor.primaryColor,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),

            // ---- Info Section ----
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: item.title,
                        textColor: ConstColor.black,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isOwner ? ConstColor.primaryColor.withAlpha(20) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CustomText(
                          title: item.role,
                          textColor: isOwner ? ConstColor.primaryColor : ConstColor.textColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // ─── Description ───
                  CustomText(
                    title: item.description,
                    textColor: ConstColor.textColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textHeight: 1.5,
                    maxLine: 3,
                  ),

                  SizedBox(height: 20.h),

                  // ─── Stats Bottom Row ───
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatColumn(label: 'Members', value: item.members),
                      _StatColumn(label: 'Groups', value: item.groups),
                      _StatColumn(label: 'Competitions', value: item.competitions),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper Widget for Bottom Stats ───
class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: label,
          textColor: ConstColor.textColor,
          textSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 4.h),
        CustomText(
          title: value,
          textColor: ConstColor.black,
          textSize: 15.sp,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}