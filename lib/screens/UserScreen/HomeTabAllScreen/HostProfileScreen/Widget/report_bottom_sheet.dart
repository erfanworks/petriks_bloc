import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/text/custom_text.dart';
import '../Controller/host_profile_controller.dart';

class ReportBottomSheet {
  static void show(BuildContext context, HostProfileController c) {
    c.resetReport();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ReportSheet(c: c),
    );
  }
}

class _ReportSheet extends StatelessWidget {
  const _ReportSheet({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Obx(() => c.isReportSubmitted.value
          ? _SuccessView(c: c)
          : _ReportFormView(c: c)),
    );
  }
}

// ── Report form ──
class _ReportFormView extends StatelessWidget {
  const _ReportFormView({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ConstColor.borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: ConstString.reportUser,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close_rounded,
                    color: ConstColor.black, size: 22.r),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: ConstString.helpUsUnderstand,
            textSize: 14.sp,
            textColor: ConstColor.iconColor,
            maxLine: 1,
          ),
          SizedBox(height: 16.h),

          // Reporting user card
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: ConstColor.backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: AppImage(
                        path: 'assets/images/onboarding1_img.jpg',
                        width: 50.r,
                        height: 50.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14.r,
                        height: 14.r,
                        decoration: const BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.verified,
                            color: Colors.white, size: 9.r),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: ConstString.reporting,
                      textSize: 12.sp,
                      textColor: ConstColor.primaryColor,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: 'Marcus Chen',
                      textSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          CustomText(
            title: ConstString.whyReporting,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
          SizedBox(height: 16.h),

          // Reason options
          Obx(() => Column(
            children: c.reportReasons.map((reason) {
              final selected = c.selectedReason.value == reason;
              return GestureDetector(
                onTap: () => c.selectReason(reason),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selected
                          ? ConstColor.primaryColor
                          : ConstColor.borderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: reason,
                        textSize: 15.sp,
                        textColor: ConstColor.textColor,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                      Container(
                        width: 20.r,
                        height: 20.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? ConstColor.primaryColor
                                : ConstColor.borderColor,
                            width: selected ? 5.r : 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),

          SizedBox(height: 12.h),

          // Urgency dropdown
          CustomText(
            title: ConstString.urgencyLevel,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),

          Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ConstColor.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: c.selectedUrgency.value,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: ConstColor.iconColor, size: 20.r),
                items: c.urgencyLevels
                    .map((l) => DropdownMenuItem(
                  value: l,
                  child: CustomText(
                    title: l,
                    textSize: 13.sp,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                ))
                    .toList(),
                onChanged: (v) => c.selectUrgency(v ?? 'High'),
              ),
            ),
          )),

          SizedBox(height: 20.h),

          // Submit button
          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              0,
              16.w,
              4.h + MediaQuery.of(context).padding.bottom,
            ),
            child: CustomElevatedButton(
              height: 48,
              top: 0,
              onPressed: c.submitReport,
              // color: ConstColor.primaryColor,
              gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.submitReport,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 96.r,
            height: 96.r,
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 58.r,
                height: 58.r,
                decoration: const BoxDecoration(
                  color: ConstColor.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: ConstColor.primaryColor,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_rounded,
                    color: Colors.white, size: 28.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          CustomText(
            title: ConstString.reportSubmittedSuccess,
            textSize: 22.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            textAlign: TextAlign.center,
            maxLine: 2,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: ConstString.reportSubmittedDesc,
            textSize: 14.sp,
            textColor: ConstColor.iconColor,
            textAlign: TextAlign.center,
            maxLine: 3,
          ),
          SizedBox(height: 28.h),

          CustomElevatedButton(
            top: 0,
            gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
            onPressed: () {
              c.resetReport();
              Get.back();
            },
            color: ConstColor.primaryColor,
            buttonBorderRadius: 30,
            child: CustomText(
              title: ConstString.goBack,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}