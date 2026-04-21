import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
      title: 'Tell us about you',
      subtitle: 'Help us tailor your experience with a few basic details.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Full Name ──
          CustomTextFormField(
            fromTitle: 'Full Name',
            textController: c.nameController,
            hintText: const Text('Enter name'),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                'assets/icons/ic_person.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF6B6B80), BlendMode.srcIn),
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // ── Gender dropdown ──
          _LabelField(label: 'Gender'),
          Obx(() => _DropdownField(
            hint: 'Select gender',
            value: c.selectedGender.value.isEmpty
                ? null
                : c.selectedGender.value,
            items: c.genderOptions,
            onChanged: (v) => c.selectedGender.value = v ?? '',
          )),

          SizedBox(height: 4.h),

          // ── Date of Birth ──
          CustomTextFormField(
            fromTitle: 'Date of birth',
            hintText: const Text('dd/mm/yyyy'),
            readOnly: true,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                'assets/icons/ic_calendar.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF6B6B80), BlendMode.srcIn),
              ),
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) c.selectedDob.value = picked;
            },
          ),

          SizedBox(height: 12.h),

          // ── Age band ──
          CustomText(
            title: 'Select your age band',
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: const Color(0xFF1A1A2E),
            maxLine: 1,
          ),
          SizedBox(height: 10.h),

          Obx(() => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 2.8,
            children: c.ageBands.map((band) {
              final selected = c.selectedAgeBand.value == band;
              return GestureDetector(
                onTap: () => c.selectAgeBand(band),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF6C5CE7)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF6C5CE7)
                          : const Color(0xFFE0DFF0),
                    ),
                  ),
                  child: Center(
                    child: CustomText(
                      title: band,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      textColor: selected
                          ? Colors.white
                          : const Color(0xFF1A1A2E),
                      maxLine: 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),

          SizedBox(height: 16.h),

          // ── Confirm area ──
          CustomText(
            title: 'Confirm your area',
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: const Color(0xFF1A1A2E),
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomTextFormField(
            textController: c.locationSearchController,
            hintText: const Text('Search location'),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: SvgPicture.asset(
                'assets/icons/ic_search.svg',
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                    Color(0xFF6B6B80), BlendMode.srcIn),
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
                  color: const Color(0xFFE8E0D5),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/ic_map_placeholder.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Location pin
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_location_pin.svg',
                    width: 32.r,
                    height: 32.r,
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
                    child: Icon(Icons.my_location,
                        size: 18.r, color: const Color(0xFF6C5CE7)),
                  ),
                ),
                // Location label bottom
                Positioned(
                  bottom: 8.h,
                  left: 12.w,
                  right: 50.w,
                  child: CustomText(
                    title: 'Shoreditch, London— Based on your current location',
                    textSize: 11.sp,
                    textColor: const Color(0xFF1A1A2E),
                    maxLine: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0DFF0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: CustomText(
            title: hint,
            textSize: 14.sp,
            textColor: const Color(0xFF6B6B80),
            maxLine: 1,
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF6B6B80), size: 22.r),
          items: items
              .map((e) => DropdownMenuItem(
            value: e,
            child: CustomText(
              title: e,
              textSize: 14.sp,
              textColor: const Color(0xFF1A1A2E),
              maxLine: 1,
            ),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}