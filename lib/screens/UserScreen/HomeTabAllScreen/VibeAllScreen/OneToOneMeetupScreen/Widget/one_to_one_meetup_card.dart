import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/one_to_one_meetup_controller.dart';

class OneToOneMeetupCard extends StatelessWidget {
  final OneToOneMeetupItem item;

  const OneToOneMeetupCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OneToOneMeetupController>();

    return GestureDetector(
      onTap: () => controller.onEventTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Person Row ----
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                children: [
                  // Person image with verified badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: AppImage(
                          path: item.personImage,
                          width: 73.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 18.w,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: ConstColor.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5.w),
                          ),
                          child: Icon(Icons.check_rounded, color: Colors.white, size: 10.sp),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 12.w),

                  // Person info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: item.personName,
                          textColor: ConstColor.black,
                          textSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.language_rounded, size: 13.sp, color: ConstColor.grey),
                            SizedBox(width: 4.w),
                            CustomText(title: item.language, textColor: ConstColor.grey, textSize: 12.sp, maxLine: 1),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 13.sp, color: ConstColor.grey),
                            SizedBox(width: 4.w),
                            CustomText(title: item.distance, textColor: ConstColor.grey, textSize: 12.sp, maxLine: 1),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // View Profile button
                  GestureDetector(
                    onTap: () => controller.onViewProfile(item),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: ConstColor.primaryColor),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomText(
                        title: ConstString.viewProfile,
                        textColor: ConstColor.black,
                        textSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---- Event Image ----
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AppImage(
                      path: item.eventImage,
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Tag badge
                Positioned(
                  bottom: 48.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: item.tag,
                      textColor: const Color(0xFFFF9800),
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ),
                ),

                // Event details overlay — bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: item.eventTitle,
                              textColor: ConstColor.black,
                              textSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                            ),
                            if (item.isFreeEntry)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDE9FF),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: CustomText(
                                  title: ConstString.freeEntry,
                                  textColor: ConstColor.primaryColor,
                                  textSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 1,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 12.sp, color: ConstColor.grey),
                            SizedBox(width: 4.w),
                            CustomText(title: item.location, textColor: ConstColor.primaryColor, textSize: 11.sp, maxLine: 1),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 12.sp, color: ConstColor.primaryColor),
                            SizedBox(width: 4.w),
                            CustomText(title: item.date, textColor: ConstColor.grey, textSize: 11.sp, maxLine: 1),
                            SizedBox(width: 8.w),
                            Icon(Icons.access_time_rounded, size: 12.sp, color: ConstColor.primaryColor),
                            SizedBox(width: 4.w),
                            CustomText(title: item.time, textColor: ConstColor.grey, textSize: 11.sp, maxLine: 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}