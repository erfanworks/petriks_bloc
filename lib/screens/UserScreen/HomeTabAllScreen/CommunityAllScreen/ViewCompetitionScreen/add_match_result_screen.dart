import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'Controller/view_competition_controller.dart';
import 'Widget/vs_banner.dart';

class AddMatchResultScreen extends StatelessWidget {
  const AddMatchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ViewCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.addMatchResult),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- VS Banner ----
            VSBanner(showWinner: false),

            SizedBox(height: 24.h),

            // ---- Select Winner ----
            CustomText(
              title: ConstString.selectWinner,
              textColor: ConstColor.black,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),

            SizedBox(height: 12.h),

            Obx(
                  () => Row(
                children: [
                  _WinnerCard(
                    label: 'Group A',
                    sublabel: 'Winner',
                    emoji: '🏆',
                    isSelected: c.selectedWinner.value == 0,
                    onTap: () => c.selectWinner(0),
                  ),
                  SizedBox(width: 10.w),
                  _WinnerCard(
                    label: 'Group B',
                    sublabel: 'Opponent',
                    isSelected: c.selectedWinner.value == 1,
                    onTap: () => c.selectWinner(1),
                  ),
                  SizedBox(width: 10.w),
                  _WinnerCard(
                    label: 'Draw',
                    sublabel: 'Equal Score',
                    isSelected: c.selectedWinner.value == 2,
                    onTap: () => c.selectWinner(2),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Notes ----
            CustomText(
              title: ConstString.notes,
              textColor: ConstColor.black,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
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

            SizedBox(height: 38.h),

            CustomElevatedButton(
              onPressed: c.confirmResult,
              height: 48,
              top: 0,
              bottom: 10,
              buttonBorderRadius: 30,
              gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
              child: CustomText(
                title: ConstString.confirmResult,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),

            CustomElevatedButton(
              onPressed: () => Get.back(),
              height: 48,
              top: 0,
              elevation: 0,
              buttonBorderRadius: 30,
              isOutLined: true,
              outLineColour: ConstColor.grey,
              child: CustomText(
                title: ConstString.cancel,
                textColor: ConstColor.black,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _WinnerCard extends StatelessWidget {
  final String label;
  final String sublabel;
  final String? emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _WinnerCard({
    required this.label,
    required this.sublabel,
    this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEDE9FF) : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: isSelected ? Border.all(color: ConstColor.primaryColor, width: 1.5.w) : null,
          ),
          child: Column(
            children: [
              if (emoji != null) Text(emoji!, style: TextStyle(fontSize: 18.sp)),
              if (emoji != null) SizedBox(height: 4.h),
              CustomText(
                title: label,
                textColor: isSelected ? ConstColor.primaryColor : ConstColor.black,
                textSize: 14.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
              SizedBox(height: 2.h),
              CustomText(
                title: sublabel,
                textColor: ConstColor.grey,
                textSize: 10.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}