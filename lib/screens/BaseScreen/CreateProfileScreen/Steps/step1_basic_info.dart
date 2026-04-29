import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/text/custom_text.dart';
import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';

class Step1BasicInfo extends StatelessWidget {
  const Step1BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.tellUsAboutYou,
      subtitle: ConstString.helpUsTailor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Full Name ──
          CustomTextFormField(
            onChanged: (_) => c.selectedAgeBand.refresh(),
            fromTitle: ConstString.fullName,
            textController: c.nameController,
            backgroundColor: ConstColor.boxColor,
            hintText: const Text(
              ConstString.enterName,
              style: TextStyle(color: ConstColor.iconColor,
              fontWeight: FontWeight.w400,
              ),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(16.r),
              child: SvgPicture.asset(
                'assets/icons/person_icon.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  ConstColor.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // ── Gender dropdown ──
          _LabelField(label: 'Gender'),
          Obx(
            () => _DropdownField(
              hint: 'Select gender',
              value: c.selectedGender.value.isEmpty
                  ? null
                  : c.selectedGender.value,
              items: c.genderOptions,
              onChanged: (v) => c.selectedGender.value = v ?? '',
            ),
          ),

          SizedBox(height: 4.h),

          // ── Date of Birth ──
          CustomTextFormField(
            fromTitle: ConstString.dateOfBirth,
            textController: c.dobController,
            hintText: const Text('dd/mm/yyyy'),
            readOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(16.r),
              child: SvgPicture.asset(
                'assets/icons/calender_icon.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  ConstColor.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) c.selectDob(picked);
            },
          ),

          SizedBox(height: 12.h),

          // ── Age band ──
          CustomText(
            title: ConstString.selectYourAge,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.textColor,
            maxLine: 1,
          ),
          SizedBox(height: 10.h),

          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 3.1,
              children: c.ageBands.map((band) {
                final selected = c.selectedAgeBand.value == band;
                return GestureDetector(
                  onTap: () => c.selectAgeBand(band),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF6C5CE7) : ConstColor.boxColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: selected
                            ? ConstColor.primaryDeepColor
                            : ConstColor.borderColor,
                      ),
                    ),
                    child: Center(
                      child: CustomText(
                        title: band,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        textColor: selected
                            ? Colors.white
                            : const Color(0xFF1A1A2E),
                        maxLine: 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 16.h),

          // ── Confirm area ──
          CustomText(
            title: ConstString.confirmYourArea,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.textColor,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            textController: c.locationSearchController,
            backgroundColor: ConstColor.boxColor,
            hintText: const Text(
              ConstString.searchLocation,
              style: TextStyle(color: ConstColor.iconColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(16.r),
              child: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  ConstColor.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // ── Map placeholder ──
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Stack(
              children: [
                Container(
                  height: 160.h,
                  width: double.infinity,
                  color: const Color(0xFFE8E0D5),
                  child: Image.asset(
                    "assets/images/map_img.png",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Location pin
                Positioned(
                  top: 55.h,
                  left: 140.h,

                  child: Container(
                    width: 32.r,
                    height: 46.r,
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(125),
                          blurRadius: 6.r,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/location_icon.svg',
                        width: 18.r,
                        height: 18.r,
                        colorFilter: ColorFilter.mode(ConstColor.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                // GPS button
                Positioned(
                  right: 10.w,
                  bottom: 30.h,
                  child: Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 6.r,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/location_pin.svg',
                        width: 18.r,
                        height: 18.r,
                        colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/current_location_icon.svg',
                width: 14.r,
                height: 14.r,
                colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
              ),
              SizedBox(width: 8.w,),
              CustomText(
                title: 'Shoreditch, London— Based on your \ncurrent location',
                textSize: 14.sp,
                textColor: ConstColor.silverGray20,
                fontWeight: FontWeight.w500,
                maxLine: 3,
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// ── Helper label ──
class _LabelField extends StatelessWidget {
  const _LabelField({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: CustomText(
        title: label,
        textSize: 14.sp,
        fontWeight: FontWeight.w600,
        textColor: const Color(0xFF1A1A2E),
        maxLine: 1,
      ),
    );
  }
}

// ── Dropdown field ──
class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(90.r),
        border: Border.all(color: const Color(0xFFE0DFF0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: CustomText(
            title: hint,
            textSize: 15.sp,
            textColor: ConstColor.iconColor,
            maxLine: 1,
            fontWeight: FontWeight.w400,
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF6B6B80),
            size: 22.r,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: CustomText(
                    title: e,
                    textSize: 14.sp,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 1,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
