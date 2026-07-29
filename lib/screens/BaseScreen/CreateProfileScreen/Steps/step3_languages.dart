import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/text/custom_text.dart';
import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';

class Step3Languages extends StatelessWidget {
  const Step3Languages({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.whatLanguageTo,
      subtitle: ConstString.thisHelpsYouConnect,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Language chips ──
          Obx(
            () => Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: c.languages.map((lang) {
                final selected = c.selectedLanguages.contains(lang);
                return GestureDetector(
                  onTap: () => c.toggleLanguage(lang),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? ConstColor.primaryColor
                          : ConstColor.boxColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: selected
                            ? ConstColor.primaryColor
                            : ConstColor.borderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          title: lang,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          textColor: selected
                              ? Colors.white
                              : ConstColor.textColor,
                          maxLine: 1,
                        ),
                        if (selected) ...[
                          SizedBox(width: 4.w),
                          Icon(Icons.check, color: Colors.white, size: 13.r),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 28.h),

          // ── Preferred chat language ──
          CustomText(
            title: ConstString.preferredChat,
            textSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: ConstString.chooseYourPrimary,
            textSize: 14.sp,
            textColor: ConstColor.textColor,
            fontWeight: FontWeight.w400,
            maxLine: 3,
          ),
          SizedBox(height: 18.h),

          Obx(
            () => Container(
              height: 52.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: ConstColor.boxColor,
                borderRadius: BorderRadius.circular(90.r),
                border: Border.all(color: const Color(0xFFE0DFF0)),
              ),
              child: DropdownButtonHideUnderline(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    hoverColor: Colors.transparent,
                    focusColor: ConstColor.silverGray20.withAlpha(40),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    canvasColor: Colors.white,
                  ),
                  child: DropdownButton<String>(
                    value: c.preferredChatLanguage.value.isEmpty
                        ? null
                        : c.preferredChatLanguage.value,
                    hint: CustomText(
                      title: 'Select Language',
                      textSize: 14.sp,
                      textColor: ConstColor.grey,
                      maxLine: 1,
                    ),
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: const Color(0xFF6B6B80),
                      size: 22.r,
                    ),
                    items: c.chatLanguages
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
                    onChanged: (v) => c.preferredChatLanguage.value = v ?? '',
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 22.h),
          CustomText(
            title: ConstString.languageNotListed,
            textSize: 14.sp,
            textColor: ConstColor.textColor,
            fontWeight: FontWeight.w400,
            maxLine: 3,
          ),
          SizedBox(height: 12.h),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            numeric: false,
            onChanged: (val) {
              if (val.trim().isNotEmpty) {
                c.selectedLanguages.add('custom');
              } else {
                c.selectedLanguages.remove('custom');
              }
            },
          ),
        ],
      ),
    );
  }
}
