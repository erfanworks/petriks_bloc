import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/community_detail_controller.dart';
import 'Widget/group_card.dart';

class CommunityDetailScreen extends StatelessWidget {
  const CommunityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CommunityDetailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.community),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: AppImage(
                      path: 'assets/images/fitness_img.jpg',
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 24.w,
                  child: _TagBadge(label: 'FITNESS'),
                ),
                Positioned(
                  bottom: 16.h,
                  left: 32.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: 'Urban Athletes',
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
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: '1,248 members',
                            textColor: Colors.white,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.about,
                    textColor: ConstColor.black,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    title:
                        'We are a collective of high- performance movers who treat the concrete as our playground. Pushing urban endurance limits through collaborative training, competitive heat, and shared grit.',
                    textColor: ConstColor.textColor,
                    textSize: 16.sp,
                    maxLine: 6,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.communityCompetitions,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
            SizedBox(height: 10.h),
            _CompetitionBanner(),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: ConstString.groupsInCommunity,
                    textColor: ConstColor.black,
                    textSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: CustomText(
                  //     title: ConstString.seeAll,
                  //     textColor: ConstColor.primaryColor,
                  //     fontWeight: FontWeight.w600,
                  //     textSize: 14.sp,
                  //     maxLine: 1,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: c.groups.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, i) => GroupCard(
                item: c.groups[i],
                onTap: () => c.onViewGroup(c.groups[i]),
              ),
            ),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.groupProgress,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
            SizedBox(height: 10.h),
            _ProgressTable(teams: c.progressTeams),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          5.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.onJoinCommunity,
          height: 50,
          top: 0,
          buttonBorderRadius: 30,
          gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.joinCommunity,
            textColor: Colors.white,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}







// ======================================================
// Shared Small Widgets
// ======================================================

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

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

class _TagBadge extends StatelessWidget {
  final String label;

  const _TagBadge({required this.label});

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



class _CompetitionBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), Color(0xFF3730A3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF97316),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                title: 'Upcoming',
                textColor: Colors.white,
                textSize: 10.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),
          CustomText(
            title: 'SUMMER SPRINT LEAGUE',
            textColor: Colors.white.withAlpha(180),
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: 'Runners vs Sprinters',
            textColor: Colors.white,
            textSize: 28.sp,
            fontWeight: FontWeight.w800,
            maxLine: 2,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _BannerInfo(label: 'DATE', value: 'Oct 24'),
              SizedBox(width: 24.w),
              _BannerInfo(label: 'VENUE', value: 'Central Plaza'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BannerInfo extends StatelessWidget {
  final String label;
  final String value;

  const _BannerInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          textColor: Colors.white.withAlpha(160),
          fontWeight: FontWeight.w700,
          textSize: 10.sp,
          maxLine: 1,
        ),
        CustomText(
          title: value,
          textColor: Colors.white,
          textSize: 16.sp,
          fontWeight: FontWeight.w700,
          maxLine: 1,
        ),
      ],
    );
  }
}

class _ProgressTable extends StatelessWidget {
  final List<ProgressTeam> teams;

  const _ProgressTable({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                SizedBox(width: 24.w),
                CustomText(
                  title: 'POS',
                  textColor: ConstColor.grey,
                  textSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    title: 'GROUP',
                    textColor: ConstColor.grey,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
                ...['M', 'W', 'D', 'L'].map(
                  (h) => SizedBox(
                    width: 28.w,
                    child: CustomText(
                      title: h,
                      textColor: ConstColor.grey,
                      textSize: 10.sp,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...teams.map((t) => _ProgressRow(team: t)),
          // Legend
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                _LegendDot(color: ConstColor.primaryColor, label: 'MATCH'),
                SizedBox(width: 12.w),
                _LegendDot(color: const Color(0xFF4CAF50), label: 'WIN'),
                SizedBox(width: 12.w),
                _LegendDot(color: const Color(0xFFFF9800), label: 'DRAW'),
                SizedBox(width: 12.w),
                _LegendDot(color: Colors.red, label: 'LOSS'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final ProgressTeam team;

  const _ProgressRow({required this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          CustomText(
            title: team.position,
            textColor: ConstColor.primaryDeepColor,
            textSize: 18.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(width: 8.w),
          Text(team.emoji, style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: team.name,
                  textColor: ConstColor.black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                CustomText(
                  title: team.city,
                  textColor: ConstColor.grey,
                  textSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          ...[team.matches, team.wins, team.draws, team.losses].map(
            (v) => SizedBox(
              width: 28.w,
              child: CustomText(
                title: '$v',
                textColor: ConstColor.black,
                textSize: 12.sp,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 4.w),
        CustomText(
          title: label,
          textColor: ConstColor.grey,
          textSize: 10.sp,
          fontWeight: FontWeight.w700,
          maxLine: 1,
        ),
      ],
    );
  }
}




