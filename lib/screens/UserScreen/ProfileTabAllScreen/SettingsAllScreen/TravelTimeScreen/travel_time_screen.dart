import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Current Location ──
                  CustomText(
                    title: ConstString.currentLocation,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 1,
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                    title: ConstString.maximumCommute,
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
                        title: c.commuteLabel,
                        textSize: 38.sp,
                        fontWeight: FontWeight.w700,
                        textColor: const Color(0xFF1A1A2E),
                        maxLine: 1,
                      ),
                      if (!c.isFlexible) ...[
                        SizedBox(width: 6.w),
                        CustomText(
                          title: c.selectedTransport.value == 'Walking' ? ConstString.mins : ConstString.km,
                          textSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          textColor: const Color(0xFF1A1A2E),
                          maxLine: 1,
                        ),
                      ],
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
                      onChanged: c.onSliderChanged,
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
