import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/vibe_controller.dart';

class VibeEventCard extends StatelessWidget {
  final VibeEventItem item;

  const VibeEventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<VibeController>().onEventTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: ConstColor.borderColor,width: 1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

                // Group / 1:1 badge
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.people_outline,
                            color: Colors.white, size: 12.sp),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: item.type,
                          textColor: Colors.white,
                          textSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),

                // Tag badge — bottom left
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0C4AA),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: item.tag,
                      textColor: const Color(0xFF763302),
                      textSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),

            // ---- Details ----
            Padding(
              padding: EdgeInsets.all(12.r),
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
                      if (item.isFreeEntry)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FF),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: ConstColor.primaryColor,width: 1)
                          ),
                          child: CustomText(
                            title: ConstString.freeEntry,
                            textColor: ConstColor.primaryColor,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  _InfoRow(icon: Icons.language_rounded, label: item.language),
                  SizedBox(height: 4.h),
                  _InfoRow(
                      icon: Icons.location_on_outlined, label: item.location),
                  SizedBox(height: 4.h),
                  _InfoRow(
                      icon: Icons.calendar_today_outlined, label: item.date),
                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      ClipOval(
                        child: AppImage(
                          path: item.hostImage,
                          width: 45.w,
                          height: 45.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: item.hostName,
                            textColor: ConstColor.black,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                          ),
                          CustomText(
                            title: ConstString.host,
                            textColor: ConstColor.primaryColor,
                            fontWeight: FontWeight.w500,
                            textSize: 11.sp,
                            maxLine: 1,
                          ),
                        ],
                      ),

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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13.sp, color: ConstColor.primaryColor),
        SizedBox(width: 5.w),
        Flexible(
          child: CustomText(
            title: label,
            textColor: ConstColor.grey,
            textSize: 13.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ),
      ],
    );
  }
}