import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../Controller/my_plan_controller.dart';

class EditPlanScreen extends StatelessWidget {
  const EditPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyPlanController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.editPlan),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomTextFormField(
                    backgroundColor: ConstColor.white,
                    fromTitle: ConstString.title,
                    textController: c.titleController,
                    hintText: const SizedBox.shrink(),
                  ),
                  SizedBox(height: 12.h),

                  // Activity chips
                  _FieldLabel(label: ConstString.activity),
                  SizedBox(height: 8.h),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: c.activities.map((act) {
                          final sel = c.selectedActivity.value == act;
                          return GestureDetector(
                            onTap: () => c.selectedActivity.value = act,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              margin: EdgeInsets.only(right: 8.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: sel
                                    ? ConstColor.primaryColor
                                    : ConstColor.boxColor,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: sel
                                      ? ConstColor.primaryColor
                                      : ConstColor.borderColor,
                                ),
                              ),
                              child: CustomText(
                                title: act,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                textColor: sel
                                    ? Colors.white
                                    : ConstColor.black,
                                maxLine: 1,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),

                  Obx(
                    () => _DropdownField(
                      label: ConstString.selectDate,
                      value: c.selectedDate.value,
                      icon: 'assets/icons/calender_icon.svg',
                      onTap: () => c.pickDate(context),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  _FieldLabel(label: ConstString.selectTime),
                  SizedBox(height: 8.h),
                  Obx(
                    () => _DropdownField(
                      value: c.selectedTime1.value,
                      icon: 'assets/icons/clock_icon.svg',
                      onTap: () => c.pickTime(context, isFirst: true),
                    ),
                  ),
                  // SizedBox(height: 8.h),
                  // Obx(
                  //   () => _DropdownField(
                  //     value: c.selectedTime2.value,
                  //     icon: 'assets/icons/clock_icon.svg',
                  //     onTap: () {},
                  //   ),
                  // ),
                  SizedBox(height: 10.h),

                  Obx(
                    () => _ToggleCard(
                      icon: Icons.list_alt_rounded,
                      title: ConstString.letPeopleVoteTime,
                      subtitle: ConstString.voteTimeSubtitle,
                      value: c.voteOnTime.value,
                      onChanged: (v) => c.voteOnTime.value = v,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // Pick a place
                  _FieldLabel(label: ConstString.pickAPlace),
                  SizedBox(height: 8.h),

                  // Map placeholder
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: Stack(
                      children: [
                        Container(
                          height: 160.h,
                          width: double.infinity,
                          color: const Color(0xFFE8E0D5),
                          child: Image.asset(
                            "assets/images/centarl_park_img.png",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          left: 10.w,
                          right: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/location_icon.svg',
                                  width: 16.r,
                                  height: 16.r,
                                  colorFilter: const ColorFilter.mode(
                                    ConstColor.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: 'Central Park',
                                        textSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: ConstColor.black,
                                        maxLine: 1,
                                      ),
                                      CustomText(
                                        title: 'Manhattan, NY 10024',
                                        textSize: 11.sp,
                                        textColor: ConstColor.textColor,
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Add location
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: Center(
                      child: CustomText(
                        title: ConstString.addLocation,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        textColor: ConstColor.grey,
                        maxLine: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Vote on place toggle
                  Obx(
                    () => _ToggleCard(
                      icon: Icons.list_alt_rounded,
                      title: ConstString.letPeopleVotePlace,
                      subtitle: ConstString.votePlaceSubtitle,
                      value: c.voteOnPlace.value,
                      onChanged: (v) => c.voteOnPlace.value = v,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),

          // Save Changes
          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              0,
              16.w,
              4.h + MediaQuery.of(context).padding.bottom,
            ),
            child: CustomElevatedButton(
              top: 0,
              onPressed: () => Get.back(),
              gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.saveChanges,
                textSize: 16.sp,
                fontWeight: FontWeight.w500,
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => CustomText(
    title: label,
    textSize: 16.sp,
    fontWeight: FontWeight.w700,
    textColor: ConstColor.black,
    maxLine: 1,
  );
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.value,
    required this.icon,
    required this.onTap,
    this.label,
  });

  final String value, icon;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          _FieldLabel(label: label!),
          SizedBox(height: 6.h),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ConstColor.borderColor),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 16.r,
                  height: 16.r,
                  colorFilter: const ColorFilter.mode(
                    ConstColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    title: value,
                    textSize: 16.sp,
                    textColor: ConstColor.black,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ConstColor.textColor,
                  size: 20.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ConstColor.borderColor),
    ),
    child: Row(
      children: [
        Container(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            color: ConstColor.boxColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.r, color: ConstColor.primaryColor),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              CustomText(
                title: subtitle,
                textSize: 13.sp,
                textColor: ConstColor.grey,
                fontWeight: FontWeight.w500,
                maxLine: 2,
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ConstColor.primaryDeepColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    ),
  );
}
