import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../Controller/home_controller.dart';

class EasyMeetupCard extends StatelessWidget {
  final MeetupItem item;

  const EasyMeetupCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: item.cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ConstColor.borderColor, width: 1.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36.w,
            height: 36.h,
            child: Center(
              child: SvgPicture.asset(
                item.icon,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  item.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          CustomText(
            title: item.title,
            textColor: const Color(0xFF1A1A2E),
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            maxLine: 2,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: item.subtitle,
            textColor: ConstColor.grey,
            textSize: 10.sp,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}