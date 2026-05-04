import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/terms_controller.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TermsController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.termsAndCondition,
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Updated Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ConstColor.boxColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomText(
                title: ConstString.lastUpdated,
                textSize: 12.sp,
                textColor: ConstColor.grey,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 16.h),

            // Our Agreement
            CustomText(
              title: ConstString.ourAgreement,
              textSize: 22.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.black,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 10.h),
            CustomText(
              title: ConstString.ourAgreementDesc,
              textSize: 14.sp,
              textColor: ConstColor.textColor,
              maxLine: 10,
            ),
            SizedBox(height: 24.h),

            // Section 1
            _SectionTitle(title: ConstString.terms1Title),
            SizedBox(height: 12.h),
            _ContentCard(
              children: [
                CustomText(
                  title: ConstString.terms1Para1,
                  textSize: 14.sp,
                  textColor: ConstColor.textColor,
                  maxLine: 20,
                ),
                SizedBox(height: 12.h),
                CustomText(
                  title: ConstString.terms1Para2,
                  textSize: 14.sp,
                  textColor: ConstColor.textColor,
                  maxLine: 10,
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Section 2
            _SectionTitle(title: ConstString.terms2Title),
            SizedBox(height: 12.h),
            _ContentCard(
              children: [
                CustomText(
                  title: ConstString.terms2Para1,
                  textSize: 14.sp,
                  textColor: ConstColor.textColor,
                  maxLine: 20,
                ),
                SizedBox(height: 10.h),
                _BulletItem(text: ConstString.terms2Bullet1),
              ],
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 4.w,
            decoration: BoxDecoration(
              color: ConstColor.primaryColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              title: title,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.black,
              maxLine: 2,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final List<Widget> children;

  const _ContentCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 3.h, right: 8.w),
          child: Icon(
            Icons.check_circle_outline_rounded,
            size: 16.sp,
            color: ConstColor.primaryColor,
          ),
        ),
        Expanded(
          child: CustomText(
            title: text,
            textSize: 14.sp,
            textColor: ConstColor.textColor,
            maxLine: 5,
          ),
        ),
      ],
    );
  }
}
