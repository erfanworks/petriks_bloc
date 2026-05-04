import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/language_preference_controller.dart';

class LanguagePreferenceScreen extends StatelessWidget {
  const LanguagePreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LanguagePreferenceController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.languagePreference, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: c.allLanguages.map((lang) {
                      final isSelected = c.selectedLanguages.contains(lang);
                      return GestureDetector(
                        onTap: () => c.onLanguageToggle(lang),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? ConstColor.primaryColor : ConstColor.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: isSelected ? ConstColor.primaryColor : ConstColor.borderColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                title: lang,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                textColor: isSelected ? ConstColor.white : ConstColor.textColor,
                                maxLine: 1,
                              ),
                              if (isSelected) ...[
                                SizedBox(width: 6.w),
                                Icon(Icons.check, size: 14.sp, color: ConstColor.white),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                  SizedBox(height: 28.h),

                  CustomText(
                    title: ConstString.preferredChatLanguage,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    title: ConstString.preferredChatLangDesc,
                    textSize: 13.sp,
                    textColor: ConstColor.grey,
                    maxLine: 3,
                  ),
                  SizedBox(height: 14.h),

                  Obx(() => GestureDetector(
                    onTap: () => c.isDropdownOpen.value = !c.isDropdownOpen.value,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: ConstColor.boxColor,
                        borderRadius: BorderRadius.circular(32.r),
                        border: Border.all(color: ConstColor.borderColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              title: c.selectedChatLanguage.value.isEmpty
                                  ? ConstString.selectLanguage
                                  : c.selectedChatLanguage.value,
                              textSize: 14.sp,
                              textColor: c.selectedChatLanguage.value.isEmpty
                                  ? ConstColor.grey
                                  : ConstColor.black,
                              maxLine: 1,
                            ),
                          ),
                          Icon(
                            c.isDropdownOpen.value
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 20.sp,
                            color: ConstColor.grey,
                          ),
                        ],
                      ),
                    ),
                  )),

                  // Dropdown options
                  Obx(() => c.isDropdownOpen.value
                      ? Container(
                    margin: EdgeInsets.only(top: 4.h),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ConstColor.borderColor),
                      boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
                    ),
                    child: Column(
                      children: c.allLanguages
                          .where((l) => l != '+ More')
                          .map((lang) => GestureDetector(
                        onTap: () => c.onChatLanguageSelected(lang),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            children: [
                              Expanded(child: CustomText(title: lang, textSize: 14.sp, textColor: ConstColor.black, maxLine: 1)),
                              if (c.selectedChatLanguage.value == lang)
                                Icon(Icons.check, size: 16.sp, color: ConstColor.primaryColor),
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  )
                      : const SizedBox.shrink()),
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
        gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
        onPressed: onSave,
        height: 48,
        top: 0,
        buttonBorderRadius: 30,
        child: CustomText(title: ConstString.save, textSize: 16.sp, fontWeight: FontWeight.w500, textColor: ConstColor.white, maxLine: 1),
      ),
    );
  }
}