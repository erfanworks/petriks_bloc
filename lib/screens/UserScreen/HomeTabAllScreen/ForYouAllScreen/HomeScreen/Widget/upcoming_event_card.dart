import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/home_controller.dart';


class UpcomingEventCard extends StatelessWidget {
  final EventItem item;

  const UpcomingEventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Event Image ----
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
                  height: 220.h,
                  fit: BoxFit.cover,
                ),
              ),

              // OPEN badge
              if (item.isOpen)
                Positioned(
                  top: 14.h,
                  left: 14.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: 'OPEN',
                      textColor: const Color(0xFF15803D),
                      textSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ),

              // Bookmark icon
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: ConstColor.silverGray20,
                    shape: BoxShape.circle,
                    border: Border.all(color: ConstColor.grey,width: 1)
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/icons/book_mark_icon.svg",
                      width: 12.w,
                      height: 15.h,
                    ),
                  )
                ),
              ),
            ],
          ),

          // ---- Event Details ----
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        title: item.title,
                        textColor: const Color(0xFF1A1A2E),
                        textSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                    ),
                    if (item.isFreeEntry)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE9FF),
                          borderRadius: BorderRadius.circular(20.r),
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

                // Tag
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EDFF),
                    borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: ConstColor.borderColor,width: 1)
                  ),
                  child: CustomText(
                    title: item.tag,
                    textColor: ConstColor.primaryColor,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),

                SizedBox(height: 8.h),

                // Location
                _InfoRow(icon: Icons.location_on_outlined, label: item.location),
                SizedBox(height: 4.h),

                // Date + Time
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 13.sp, color: ConstColor.primaryDeepColor),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: item.date,
                      textColor: ConstColor.silverGray20,
                      textSize: 13.sp,
                      maxLine: 1,
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.access_time,
                        size: 13.sp, color: ConstColor.primaryDeepColor),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: item.time,
                      textColor: ConstColor.silverGray20,
                      textSize: 13.sp,
                      maxLine: 1,
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Joined + Invite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_outline,
                            size: 14.sp, color: ConstColor.primaryDeepColor),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: item.joined,
                          textColor: ConstColor.silverGray20,
                          textSize: 13.sp,
                          maxLine: 1,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_add_alt_1_outlined,
                              size: 13.sp, color: ConstColor.primaryColor),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: 'INVITE',
                            textColor: ConstColor.primaryColor,
                            textSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
        Icon(icon, size: 14.sp, color: ConstColor.primaryDeepColor),
        SizedBox(width: 4.w),
        Flexible(
          child: CustomText(
            title: label,
            textColor: ConstColor.silverGray20,
            textSize: 13.sp,
            maxLine: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}