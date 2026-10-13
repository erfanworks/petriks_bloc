import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widget/text/custom_text.dart';
import '../../constant/const_color.dart';
import '../../constant/const_string.dart';
import '../AppImage/app_image.dart';

class GroupHeaderWidget extends StatelessWidget {
  final String image;
  final String tag;
  final String title;
  final String memberCount;

  const GroupHeaderWidget({
    super.key,
    this.image = 'assets/images/football_play.jpg',
    this.tag = 'FITNESS',
    this.title = 'Morning Runners',
    this.memberCount = '1,248 members',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          path: image,
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(70),
                  Colors.transparent,
                  Colors.black.withAlpha(180),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: GroupTagBadge(label: tag),
        ),
        Positioned(
          bottom: 16.h,
          left: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                textColor: Colors.white,
                textSize: 24.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: memberCount,
                    textColor: Colors.white,
                    textSize: 16.sp,
                    maxLine: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupTagBadge extends StatelessWidget {
  final String label;

  const GroupTagBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ConstColor.white.withAlpha(180),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        title: label,
        textColor: ConstColor.primaryColor,
        textSize: 12.sp,
        fontWeight: FontWeight.w700,
        maxLine: 1,
      ),
    );
  }
}

class GroupSectionCard extends StatelessWidget {
  final Widget child;

  const GroupSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}

class GroupAboutCard extends StatelessWidget {
  final String aboutText;

  const GroupAboutCard({
    super.key,
    this.aboutText =
        'We are a collective of high- performance movers who treat the concrete as our playground. Pushing urban endurance limits through collaborative training, competitive heat, and shared grit.',
  });

  @override
  Widget build(BuildContext context) {
    return GroupSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.about,
            textColor: ConstColor.black,
            textSize: 20.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: aboutText,
            textColor: ConstColor.grey,
            textSize: 15.sp,
            maxLine: 6,
          ),
        ],
      ),
    );
  }
}

class GroupProgressCard extends StatelessWidget {
  final String matches;
  final String wins;
  final String globalRank;
  final String nextMatch;

  const GroupProgressCard({
    super.key,
    this.matches = '6',
    this.wins = '4',
    this.globalRank = '#2',
    this.nextMatch = 'Sunday',
  });

  @override
  Widget build(BuildContext context) {
    return GroupSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.groupProgress,
            textColor: ConstColor.black,
            textSize: 15.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              GroupStatBox(
                icon: Icons.flag_outlined,
                iconColor: ConstColor.primaryColor,
                value: matches,
                label: 'Matches',
              ),
              SizedBox(width: 16.w),
              GroupStatBox(
                icon: Icons.emoji_events_outlined,
                iconColor: const Color(0xFFFF9800),
                value: wins,
                label: 'Wins',
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              GroupStatBox(
                icon: Icons.bar_chart_rounded,
                iconColor: ConstColor.primaryColor,
                value: globalRank,
                label: 'GLOBAL RANK',
              ),
              SizedBox(width: 16.w),
              GroupStatBox(
                icon: Icons.calendar_today_outlined,
                iconColor: ConstColor.primaryColor,
                value: nextMatch,
                label: 'Next Match',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GroupStatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const GroupStatBox({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: value,
                textColor: ConstColor.black,
                textSize: 18.sp,
                fontWeight: FontWeight.w800,
                maxLine: 1,
              ),
              CustomText(
                title: label,
                textColor: ConstColor.grey,
                fontWeight: FontWeight.w500,
                textSize: 10.sp,
                maxLine: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
