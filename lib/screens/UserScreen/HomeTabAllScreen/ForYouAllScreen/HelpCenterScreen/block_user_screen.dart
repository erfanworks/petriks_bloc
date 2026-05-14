import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../PlanDetailsScreen/Controller/plan_details_controller.dart';

class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.blockUser),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.blockThisUser,
              textColor: ConstColor.black,
              textSize: 16.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 14.h),

            Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/person1_img.jpg',
                        width: 56.w,
                        height: 56.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 18.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5.w),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 10.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: ConstString.host,
                      textColor: ConstColor.primaryColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: 'Marcus Chen',
                      textColor: ConstColor.black,
                      textSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.h),

            CustomText(
              title: ConstString.whatHappensBlock,
              textColor: ConstColor.black,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 12.h),

            _BlockInfoCard(
              icon: Icons.visibility_off_outlined,
              iconColor: Color(0xFFBA1A1A),
              title: ConstString.mutualPrivacy,
              desc: ConstString.mutualPrivacyDesc,
            ),
            _BlockInfoCard(
              icon: Icons.block_outlined,
              iconColor: Color(0xFFBA1A1A),
              title: ConstString.noContact,
              desc: ConstString.noContactDesc,
            ),
            _BlockInfoCard(
              icon: Icons.shield_outlined,
              iconColor: Color(0xFFBA1A1A),
              title: ConstString.safeEnvironment,
              desc: ConstString.safeEnvironmentDesc,
            ),

            const Spacer(),

            Padding(
              padding: EdgeInsets.fromLTRB(
                0.w,
                0,
                0.w,
                0.h + MediaQuery.of(context).padding.bottom,
              ),
              child: CustomElevatedButton(
                onPressed: controller.blockUser,
                height: 50,
                top: 0,
                buttonBorderRadius: 30,
                gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
                child: CustomText(
                  title: ConstString.block,
                  textColor: Colors.white,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _BlockInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String desc;

  const _BlockInfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  title: desc,
                  textColor: ConstColor.grey,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}