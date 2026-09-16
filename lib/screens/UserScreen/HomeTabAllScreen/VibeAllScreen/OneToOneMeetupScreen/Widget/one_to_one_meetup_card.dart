import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          border: Border.all(color: ConstColor.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 10.r,
              spreadRadius: 1.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5.w,
                            ),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 12.w),

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
                            Icon(
                              Icons.language_rounded,
                              size: 13.sp,
                              color: ConstColor.primaryColor,
                            ),
                            SizedBox(width: 4.w),
                            CustomText(
                              title: item.language,
                              textColor: ConstColor.textColor,
                              textSize: 12.sp,
                              maxLine: 1,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18.sp,
                              color: ConstColor.primaryColor,
                            ),
                            SizedBox(width: 4.w),
                            CustomText(
                              title: item.location,
                              textColor: ConstColor.textColor,
                              textSize: 12.sp,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: item.isPrivate
                              ? ConstColor.black.withAlpha(40)
                              : const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            if (item.isPrivate)
                              SvgPicture.asset(
                                "assets/icons/lock_icon.svg",
                                height: 10.h,
                                width: 10.w,
                                colorFilter: const ColorFilter.mode(
                                  ConstColor.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              )
                            else
                              Icon(
                                Icons.public,
                                size: 11.sp,
                                color: const Color(0xFF2E7D32),
                              ),

                            SizedBox(width: 5.w),

                            CustomText(
                              title: item.isPrivate
                                  ? ConstString.private
                                  : "Public",
                              textColor: item.isPrivate
                                  ? ConstColor.primaryColor
                                  : const Color(0xFF2E7D32),
                              textSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      GestureDetector(
                        onTap: () => controller.onViewProfile(item),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: ConstColor.primaryColor),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            title: ConstString.viewProfile,
                            textColor: ConstColor.black,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Stack(
                  children: [
                    AppImage(
                      path: item.eventImage,
                      width: double.infinity,
                      height: 160.h,
                      fit: BoxFit.cover,
                    ),

                    // ── SPONSORED badge (bottom-left of image) ──
                    Positioned(
                      bottom: 12.h,
                      left: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB35A00),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              color: ConstColor.white ,
                              size: 13.sp,
                            ),
                            SizedBox(width: 5.w),
                            CustomText(
                              title: ConstString.partner,
                              textColor: Colors.white,
                              textSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                      width: 14.w,
                      height: 14.h,
                      "assets/icons/world_icon.svg"),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: ConstString.publicLabel,
                    textColor: ConstColor.primaryColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: item.eventTitle,
                        textColor: ConstColor.black,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      if (item.isFreeEntry)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
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
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                          width: 15.w,
                          height: 15.h,
                          "assets/icons/male_icon.svg"),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: "Male (20-25)",
                        textColor: ConstColor.textColor,
                        textSize: 12.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // ── Date/Time row + Tag badge (bottom-right) ──
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.sp,
                        color: ConstColor.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: item.date,
                        textColor: ConstColor.textColor,
                        textSize: 12.sp,
                        maxLine: 1,
                      ),

                      SizedBox(width: 8.w),
                      Container(
                        width: 1,
                        height: 12.h,
                        color: ConstColor.borderColor,
                      ),
                      SizedBox(width: 8.w),

                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: ConstColor.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: "Vote now",
                        textColor: ConstColor.primaryColor,
                        textSize: 12.sp,
                        maxLine: 1,
                      ),

                      const Spacer(),

                      // ── Tag badge moved here (bottom-right) ──
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0C4AA),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CustomText(
                          title: item.tag,
                          textColor: const Color(0xFF763302),
                          textSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
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