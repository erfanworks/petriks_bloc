import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

class CompetitionSuccessDialog extends StatelessWidget {
  const CompetitionSuccessDialog({
    super.key,
    required this.communityName,
    required this.goToViewCompetition,
    required this.onBackToCommunity,
  });

  final String communityName;
  final VoidCallback goToViewCompetition;
  final VoidCallback onBackToCommunity;

  static void show(
      BuildContext context, {
        required String communityName,
        required VoidCallback goToViewCompetition,
        required VoidCallback onBackToCommunity,
      }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(120),
      builder: (_) => CompetitionSuccessDialog(
        communityName: communityName,
        goToViewCompetition: goToViewCompetition,
        onBackToCommunity: onBackToCommunity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ConstColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Check circle ──
            Container(
              width: 70.r,
              height: 70.r,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: ConstColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_rounded,
                      color: Colors.white, size: 22.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // ── Title ──
            CustomText(
              title: ConstString.youReAllIn,
              textSize: 20.sp,
              fontWeight: FontWeight.w800,
              textColor: ConstColor.black,
              textAlign: TextAlign.center,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),

            SizedBox(height: 8.h),
            CustomText(
              title: ConstString.youReCompetitionHasBeen,
              textSize: 14.sp,
              textColor: ConstColor.textColor,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),


            SizedBox(height: 20.h),

            // Go to Community Chat button
            CustomElevatedButton(
              top: 0,
              onPressed: goToViewCompetition,
              color: ConstColor.primaryColor,
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.viewCompetition,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
                maxLine: 1,
              ),
            ),

            //Back to Discovery
            CustomElevatedButton(
              top: 8,
              onPressed: onBackToCommunity,
              color: Colors.white,
              buttonBorderRadius: 30,
              borderColor: ConstColor.borderColor,
              child: CustomText(
                title: ConstString.backToCommunity,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}