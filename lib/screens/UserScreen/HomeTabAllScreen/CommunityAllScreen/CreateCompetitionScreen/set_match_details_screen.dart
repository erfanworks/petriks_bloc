import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_competition_controller.dart';

class SetMatchDetailsScreen extends StatelessWidget {
  const SetMatchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.createCompetitions),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            CustomText(
              title: ConstString.setMatchDetails,
              textColor: ConstColor.black,
              textSize: 24.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),

            SizedBox(height: 20.h),

            // ---- Competition Title ----
            CustomText(
              title: ConstString.competitionTitle,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            _DropdownField(
              icon: Icons.edit_outlined,
              iconColor: ConstColor.primaryColor,
              value: c.titleController.text,
            ),

            SizedBox(height: 16.h),

            // ---- Match Date ----
            CustomText(
              title: ConstString.matchDate,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Obx(
              () => GestureDetector(
                onTap: () => c.pickDate(context),
                child: _DropdownField(
                  icon: Icons.calendar_today_outlined,
                  iconColor: ConstColor.primaryColor,
                  value: c.selectedDate.value,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // ---- Select Time ----
            CustomText(
              title: ConstString.selectTime,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Obx(
              () => GestureDetector(
                onTap: () => c.pickTime(context),
                child: _DropdownField(
                  icon: Icons.access_time_rounded,
                  iconColor: ConstColor.primaryColor,
                  value: c.selectedTime.value,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // ---- Notes ----
            CustomText(
              title: ConstString.notes,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ConstColor.borderColor,width: 1)
              ),
              child: TextField(
                maxLines: 8,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: ConstColor.silverGray20,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText:
                  "e.g., A community for weekly football meetups, practice matches, and social hangouts in Dhaka.",
                  hintMaxLines: 3,
                  hintStyle: TextStyle(
                    color: ConstColor.textColor.withAlpha(150),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // CustomElevatedButton(
            //   onPressed: c.goToFinalReview,
            //   height: 54,
            //   top: 0,
            //   buttonBorderRadius: 30,
            //   gradient: const [Color(0xFF7B5EA7), Color(0xFF5B2D8E)],
            //   child: CustomText(
            //     title: ConstString.continueText,
            //     textColor: Colors.white,
            //     textSize: 15.sp,
            //     fontWeight: FontWeight.w600,
            //     maxLine: 1,
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: CustomElevatedButton(
          onPressed: c.goToFinalReview,
          height: 48, top: 0, buttonBorderRadius: 30,
          gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(title: ConstString.continueText, textColor: Colors.white, textSize: 15.sp, fontWeight: FontWeight.w600, maxLine: 1),
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;

  const _DropdownField({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              title: value,
              textColor: ConstColor.black,
              textSize: 14.sp,
              maxLine: 1,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ConstColor.grey,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
