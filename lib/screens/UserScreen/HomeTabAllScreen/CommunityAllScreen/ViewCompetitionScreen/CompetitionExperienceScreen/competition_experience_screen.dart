import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/competition_experience_controller.dart';

class CompetitionExperienceScreen extends StatelessWidget {
  const CompetitionExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CompetitionExperienceController>();

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(showBack: false,),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WinningBanner(c: c),
              SizedBox(height: 28.h),

              Center(
                child: CustomText(
                  title: ConstString.howWasYourExperience,
                  textSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  textColor: ConstColor.black,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              SizedBox(height: 20.h),

              _StarRatingRow(c: c),
              SizedBox(height: 28.h),

              CustomText(
                title: ConstString.leaveAReview,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              SizedBox(height: 8.h),

              Container(
                width: double.infinity,
                height: 130.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: ConstColor.borderColor),
                ),
                child: TextField(
                  controller: c.reviewController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: ConstString.addYourThoughtsHint,
                    hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.grey),
                  ),
                ),
              ),

              SizedBox(height: 40.h),


            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.onSubmitReview,
          height: 48,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.submitAReview,
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

class _WinningBanner extends StatelessWidget {
  final CompetitionExperienceController c;
  const _WinningBanner({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), ConstColor.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: const Color(0xFFF97316),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.emoji_events_rounded, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: '${ConstString.congratulationsTo} ${ConstString.winningTeamSuffix} ${c.winningTeamName.value}!',
                    textColor: Colors.white,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 3,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: c.leagueName.value,
                    textColor: Colors.white.withAlpha(180),
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRatingRow extends StatelessWidget {
  final CompetitionExperienceController c;
  const _StarRatingRow({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          final filled = index < c.selectedRating.value;
          return GestureDetector(
            onTap: () => c.onStarTap(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Icon(
                filled ? Icons.star_rounded : Icons.star_border_rounded,
                size: 34.sp,
                color: filled ? const Color(0xFFF97316) : ConstColor.borderColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}