// ── Step 7: What's your mood today? ──
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../widget/text/custom_text.dart';
import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';

class Step7Mood extends StatelessWidget {
  const Step7Mood({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.whatsYourMood,
      subtitle:ConstString.pickHowYour,
      child: Obx(() => Column(
        children: c.moodOptions.map((opt) {
          final selected = c.selectedMood.value == opt['label'];
          return GestureDetector(
            onTap: () => c.selectMood(opt['label']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF6C5CE7)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  // Emoji circle
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EEF9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        opt['emoji']!,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: CustomText(
                      title: opt['label']!,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      textColor: const Color(0xFF1A1A2E),
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                  if (selected)
                    Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C5CE7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check,
                          color: Colors.white, size: 14.r),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}

//Step 8
class Step8Travel extends StatelessWidget {
  const Step8Travel({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.howFarWouldYou,
      subtitle:
      ConstString.adjustYourRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.currentLocation,
            textSize: 16.sp,
            fontWeight: FontWeight.w500,
            textColor: const Color(0xFF1A1A2E),
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          Obx(() => Container(
            padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE0DFF0)),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: ConstColor.textColor, size: 20.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomText(
                    title: c.currentLocation.value,
                    textSize: 14.sp,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 1,
                  ),
                ),
                GestureDetector(
                  onTap: c.editLocation,
                  child: Icon(Icons.edit_outlined,
                      color: ConstColor.primaryColor, size: 18.r),
                ),
              ],
            ),
          )),

          SizedBox(height: 20.h),

          // ── Preferred Transport ──
          CustomText(
            title: ConstString.preferredTransport,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: const Color(0xFF1A1A2E),
            maxLine: 1,
          ),
          SizedBox(height: 10.h),

          Obx(() => Row(
            children: c.transportOptions.map((t) {
              final selected = c.selectedTransport.value == t;
              return Expanded(
                child: GestureDetector(
                  onTap: () => c.selectTransport(t),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: EdgeInsets.only(
                        right: t == 'Walking' ? 10.w : 0),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF6C5CE7).withAlpha(20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF6C5CE7)
                            : const Color(0xFFE0DFF0),
                        width: selected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          t == 'Walking'
                              ? 'assets/icons/hiking_icon.svg'
                              : 'assets/icons/driving_car_icon.svg',
                          width: 24.r,
                          height: 24.r,
                          colorFilter: ColorFilter.mode(
                            selected
                                ? ConstColor.primaryColor
                                : ConstColor.iconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          title: t,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          textColor: selected
                              ? ConstColor.primaryColor
                              : ConstColor.textColor,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )),

          SizedBox(height: 24.h),

          // ── Commute slider ──
          CustomText(
            title: ConstString.maximumComment,
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.grey,
            maxLine: 1,
          ),
          SizedBox(height: 4.h),
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              CustomText(
                title: '${c.commuteMinutes.value.toInt()}',
                textSize: 38.sp,
                fontWeight: FontWeight.w700,
                textColor: const Color(0xFF1A1A2E),
                maxLine: 1,
              ),
              SizedBox(width: 6.w),
              CustomText(
                title: c.selectedTransport.value == 'Walking' ? ConstString.mins : ConstString.km,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: const Color(0xFF1A1A2E),
                maxLine: 1,
              ),
            ],
          )),

          Obx(() => SliderTheme(
            data: SliderThemeData(
              activeTrackColor: ConstColor.primaryColor,
              inactiveTrackColor: const Color(0xFFE1E2E4),
              thumbColor: const Color(0xFF6C5CE7),
              overlayColor: const Color(0xFF6C5CE7).withAlpha(30),
              trackHeight: 4.h,
              thumbShape:
              RoundSliderThumbShape(enabledThumbRadius: 10.r),
            ),
            child: Slider(
              value: c.commuteMinutes.value,
              min: 5,
              max: 60,
              onChanged: c.setCommute,
            ),
          )),

          // Slider labels
          Obx(() {
            final unit = c.selectedTransport.value == 'Walking' ? 'm' : 'km';
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['5$unit', '20$unit', '40$unit', 'Flexible']
                  .map((l) => CustomText(
                title: l,
                textSize: 12.sp,
                textColor: const Color(0xFF6B6B80),
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ))
                  .toList(),
            );
          }),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}