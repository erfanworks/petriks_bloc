import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/view_competition_controller.dart';
import 'Widget/logistics_card.dart';
import 'Widget/roster_card.dart';

// 1 & 2. View Competition Screen (before + after register)
class ViewCompetitionScreen extends StatelessWidget {
  const ViewCompetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ViewCompetitionController>();
    final bool isOwner = c.isOwner.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.viewCompetition),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

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

            SizedBox(height: 12.h),

            _CompetitionBanner(),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.eventLogistics,
                textColor: ConstColor.black,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),

            SizedBox(height: 10.h),

            LogisticsCard(),

            SizedBox(height: 16.h),

            _MatchNotesCard(),

            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.yourTeam,
                textColor: ConstColor.black,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),

            SizedBox(height: 10.h),

            RosterCard(
              group: c.rosterGroups[0],
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            4.h + MediaQuery.of(context).padding.bottom,
          ),
          child: isOwner
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mark as completed
                    CustomElevatedButton(
                      onPressed: c.onMarkCompleted,
                      height: 48,
                      top: 0,
                      bottom: 10,
                      buttonBorderRadius: 30,
                      gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
                      child: CustomText(
                        title: ConstString.markAsCompleted,
                        textColor: Colors.white,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                    // Edit competition
                    CustomElevatedButton(
                      onPressed: c.onEditCompetition,
                      height: 48,
                      top: 0,
                      elevation: 0,
                      buttonBorderRadius: 30,
                      isOutLined: true,
                      outLineColour: ConstColor.grey,
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 16.sp,
                        color: ConstColor.black,
                      ),
                      child: CustomText(
                        title: ConstString.editCompetition,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  ],
                )
              : CustomElevatedButton(
                  onPressed: c.onRegister,
                  height: 48,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
                  child: CustomText(
                    title: ConstString.registerNow,
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

class _CompetitionBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), ConstColor.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: 'SUMMER SPRINT LEAGUE',
                    textColor: Colors.white.withAlpha(180),
                    textSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: 'Upcoming',
                      textColor: Colors.white,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomText(
                title: 'Runners vs Sprinters',
                textColor: Colors.white,
                textSize: 28.sp,
                fontWeight: FontWeight.w800,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _BannerInfo(label: 'DATE', value: 'Oct 24'),
                  Container(
                    width: 1.w,
                    height: 30.h,
                    color: Colors.white.withAlpha(60),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  _BannerInfo(label: 'VENUE', value: 'Central Plaza'),
                ],
              ),
            ],
          ),
          // Decorative circle
          Positioned(
            right: -10.w,
            bottom: -10.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(15),
              ),
            ),
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
          textSize: 10.sp,
          fontWeight: FontWeight.w700,
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

// ---- Match Notes Card ----
class _MatchNotesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDFF),
        border: Border.all(color: ConstColor.primaryColor.withAlpha(40),width: 1),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: 'Match Notes',
            textColor: ConstColor.primaryColor,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title:
                '"Friendly game between long-time rivals. Expected high intensity and mutual respect on the pitch."',
            textColor: ConstColor.primaryColor,
            textSize: 14.sp,
            maxLine: 5,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 12.sp,
                color: ConstColor.primaryColor,
              ),
              SizedBox(width: 4.w),
              CustomText(
                title: 'ORGANIZER NOTE',
                textColor: ConstColor.primaryColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                maxLine: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

