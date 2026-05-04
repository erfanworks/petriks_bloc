import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';

import '../../../../../../Widget/text/custom_text.dart';

class VSBanner extends StatelessWidget {
  final bool showWinner;

  const VSBanner({super.key, required this.showWinner});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), ConstColor.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          CustomText(
            title: 'SUMMER SPRINT LEAGUE',
            textColor: Colors.white.withAlpha(180),
            textSize: 12.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Group A
              Column(
                children: [
                  _TeamCircle(),
                  SizedBox(height: 8.h),
                  CustomText(
                    title: 'Group A',
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  if (showWinner)
                    CustomText(
                      title: 'Winners',
                      textColor: Colors.white,
                      textSize: 10.sp,
                      maxLine: 1,
                    ),
                ],
              ),

              // VS Badge
              Container(
                width: 54.w,
                height: 54.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: 'VS',
                      textColor: Colors.white,
                      textSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: 'FINALS',
                      textColor: Colors.white,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              // Group B
              Column(
                children: [
                  _TeamCircle(),
                  SizedBox(height: 8.h),
                  CustomText(
                    title: 'Group B',
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  if (showWinner)
                    CustomText(
                      title: 'Runner Up',
                      textColor: Colors.white,
                      textSize: 10.sp,
                      maxLine: 1,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(30),
        border: Border.all(color: Colors.white.withAlpha(80), width: 2.w),
      ),
      child: Icon(
        Icons.sports_soccer_rounded,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }
}
