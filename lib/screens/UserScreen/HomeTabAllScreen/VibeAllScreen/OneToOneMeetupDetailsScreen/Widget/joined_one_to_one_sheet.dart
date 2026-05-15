import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/Controller/one_to_one_meetup_details_controller.dart';

import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
class JoinedOneToOneSheet extends StatelessWidget {
  const JoinedOneToOneSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OneToOneMeetupDetailsController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          SizedBox(height: 24.h),

          // ---- Icon ----
          Container(
            width: 74.w,
            height: 74.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_add_alt_1_rounded,
              color: ConstColor.primaryColor,
              size: 34.sp,
            ),
          ),

          SizedBox(height: 16.h),

          CustomText(
            title: ConstString.joinThisPlan,
            textColor: ConstColor.black,
            textSize: 20.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),

          SizedBox(height: 12.h),

          // ---- Description ----
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: ConstColor.grey,
                fontFamily: 'Roboto',
              ),
              children: [
                const TextSpan(text: 'You are about to join '),
                TextSpan(
                  text: 'Hang out at the',
                  style: TextStyle(
                    color: ConstColor.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: ' park. You can chat with other participants after joining.',
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),

          CustomElevatedButton(
            onPressed: () => controller.onJoinConfirmed(),
            height: 50,
            top: 0,
            buttonBorderRadius: 30,
            gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
            child: CustomText(
              title: ConstString.confirm,
              textColor: Colors.white,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),

          SizedBox(height: 12.h),

          // ---- Cancel ----
          GestureDetector(
            onTap: () => Get.back(),
            child: CustomText(
              title: ConstString.cancel,
              textColor: ConstColor.black,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 12.h,)
        ],
      ),
    );
  }
}