import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_competition_controller.dart';

class FinalReviewScreen extends StatelessWidget {
  const FinalReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.createCompetitions),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            CustomText(
              title: ConstString.finalReview,
              textColor: ConstColor.black,
              textSize: 24.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 6.h),
            CustomText(
              title: ConstString.finalReviewSubtitle,
              textColor: ConstColor.grey,
              textSize: 15.sp,
              maxLine: 3,
            ),
            SizedBox(height: 20.h),

            // ---- Review Card ----
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: AppImage(
                          path: 'assets/images/football_ground.png',
                          width: double.infinity,
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            title: 'UPCOMING',
                            textColor: ConstColor.primaryColor,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: 'Sunday Championship',
                              textColor: ConstColor.black,
                              textSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                            Container(
                              width: 34.w,
                              height: 34.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7E8EA),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.emoji_events_outlined,
                                color: ConstColor.primaryColor,
                                size: 22.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          title: 'Basketball',
                          textColor: ConstColor.primaryColor,
                          textSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                        SizedBox(height: 6.h),
                        CustomText(
                          title: 'Group A vs Group B',
                          textColor: ConstColor.black,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                        SizedBox(height: 14.h),

                        _ReviewInfoRow(
                          icon: Icons.calendar_today_outlined,
                          title: 'Sunday, 5 PM',
                          subtitle: 'October 24, 2023',
                        ),

                        SizedBox(height: 10.h),
                        _ReviewInfoRow(
                          icon: Icons.location_on_outlined,
                          title: 'Central Arena',
                          subtitle: 'Stadium District, Court 4',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: CustomElevatedButton(
          onPressed: () {
            c.showSuccessDialog();
          },
          height: 48,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [
            ConstColor.primaryDeepColor,
            ConstColor.primaryColor,
          ],
          child: CustomText(
            title: ConstString.continueText,
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

class _ReviewInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ReviewInfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF0EDFF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ConstColor.primaryColor, size: 16.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: title,
              textColor: ConstColor.black,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            CustomText(
              title: subtitle,
              textColor: ConstColor.silverGray20,
              textSize: 12.sp,
              maxLine: 1,
            ),
          ],
        ),
      ],
    );
  }
}
