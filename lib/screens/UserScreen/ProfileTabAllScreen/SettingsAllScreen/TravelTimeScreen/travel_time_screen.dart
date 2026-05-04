import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/travel_time_controller.dart';

class TravelTimeScreen extends StatelessWidget {
  const TravelTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<TravelTimeController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.travelTimeTitle, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Current Location ──
                  CustomText(
                    title: ConstString.currentLocation,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18.sp,
                          color: ConstColor.textColor,
                        ),
                        SizedBox(width: 10.w),
                        Obx(
                          () => Expanded(
                            child: CustomText(
                              title: c.currentLocation.value,
                              textSize: 14.sp,
                              textColor: ConstColor.black,
                              maxLine: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // ── Maximum Commute ──
                  CustomText(
                    title: ConstString.maximumCommute,
                    textSize: 13.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          title: c.commuteLabel,
                          textSize: 38.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.black,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                        if (!c.isFlexible) ...[
                          SizedBox(width: 8.w),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: CustomText(
                              title: ConstString.mins,
                              textSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              textColor: ConstColor.black,
                              maxLine: 1,
                              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // ── Slider ──
                  Obx(
                    () => SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: ConstColor.primaryColor,
                        inactiveTrackColor: ConstColor.borderColor,
                        thumbColor: ConstColor.primaryColor,
                        overlayColor: ConstColor.primaryColor.withAlpha(30),
                        trackHeight: 4.h,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 10.r,
                        ),
                      ),
                      child: Slider(
                        value: c.commuteMinutes.value,
                        min: 5,
                        max: 60,
                        divisions: 11,
                        onChanged: c.onSliderChanged,
                      ),
                    ),
                  ),

                  // ── Slider Labels ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          [
                                ConstString.label5m,
                                ConstString.label20m,
                                ConstString.label40m,
                                ConstString.labelFlexible,
                              ]
                              .map(
                                (l) => CustomText(
                                  title: l,
                                  textSize: 12.sp,
                                  textColor: ConstColor.grey,
                                  maxLine: 1,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _SaveButton(onSave: c.onSave),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const _SaveButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.backgroundColor,
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        5.h + MediaQuery.of(context).padding.bottom,
      ),
      child: CustomElevatedButton(
        gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
        onPressed: onSave,
        height: 48,
        top: 0,
        buttonBorderRadius: 30,
        child: CustomText(
          title: ConstString.save,
          textSize: 16.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.white,
          maxLine: 1,
        ),
      ),
    );
  }
}
