import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../widget/CoverRatioHint/cover_ratio_hint.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/my_community_detail_controller.dart';

class EditCommunityScreen extends StatelessWidget {
  const EditCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyCommunityDetailController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.editCommunity, showBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cover Photo ──
            Obx(
              () => Stack(
                children: [
                  AppImage(
                    filePath: c.coverImagePath.value.isNotEmpty
                        ? c.coverImagePath.value
                        : null,
                    path: c.coverImagePath.value.isEmpty
                        ? 'assets/images/fitness_img.jpg'
                        : null,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => MediaPickerBottomSheet.show(
                          onGallery: c.pickFromGallery,
                          onCamera: c.pickFromCamera,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(140),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                              SizedBox(width: 6.w),
                              CustomText(
                                title: ConstString.changeCover,
                                textSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.white,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
              child: const CoverRatioHint(ratio: '2:1', size: '1200 × 600 px'),
            ),

            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Community Name ──
                  _Label(ConstString.communityName),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 18.sp,
                          color: ConstColor.primaryColor,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: c.nameController,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: ConstColor.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Short Description ──
                  _Label(ConstString.shortDescription),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: TextField(
                      controller: c.descController,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ConstColor.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: ConstString.shortDescHint,
                        hintStyle: TextStyle(
                          color: ConstColor.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Language Spoken ──
                  _Label(ConstString.languageSpoken),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        ...c.selectedLanguages.map(
                          (lang) => _Chip(
                            label: lang,
                            onRemove: () => c.removeLanguage(lang),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Dropdown(
                          hint: ConstString.selectOtherLanguage,
                          items: [
                            ...c.availableLanguages
                                .where((l) => !c.selectedLanguages.contains(l))
                                .toList(),
                            ConstString.otherAddLanguageManually,
                          ],
                          onChanged: (val) {
                            if (val != null) c.addLanguage(val);
                          },
                        ),
                        if (c.showCustomLanguageField.value) ...[
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            textController: c.customLanguageController,
                            hintText: CustomText(
                              title: "Enter language manually",
                              textSize: 14.sp,
                              textColor: ConstColor.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: c.addCustomLanguage,
                              icon: const Icon(Icons.check,
                                  color: ConstColor.primaryColor),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  SizedBox(height: 16.h),

                  // ── Interests ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Label(ConstString.interest),
                      GestureDetector(
                        onTap: () => _showInterestSheet(context, c),
                        child: CustomText(
                          title: ConstString.editInterests,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.primaryColor,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: c.selectedInterests
                          .map((item) => _InterestChip(item: item))
                          .toList(),
                    ),
                  ),

                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          16.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.onSave,
          height: 48,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [
            ConstColor.primaryDeepColor,
            ConstColor.primaryColor,
          ],
          child: CustomText(
            title: ConstString.save,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: Colors.white,
            maxLine: 1,
          ),
        ),
      ),
    );
  }

  void _showInterestSheet(BuildContext context, MyCommunityDetailController c) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          24.h + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: ConstColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ConstColor.borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              title: ConstString.editInterests,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
            SizedBox(height: 16.h),
            Obx(
              () => Wrap(
                spacing: 8.w,
                runSpacing: 10.h,
                children: c.allInterests.map((item) {
                  final isSelected = c.selectedInterests.any(
                    (s) => s['label'] == item['label'],
                  );
                  return GestureDetector(
                    onTap: () => c.toggleInterest(item),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ConstColor.primaryColor.withAlpha(20)
                            : ConstColor.boxColor,
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: isSelected
                              ? ConstColor.primaryColor
                              : ConstColor.borderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item['icon']!,
                            width: 16.r,
                            height: 16.r,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? ConstColor.primaryColor
                                  : ConstColor.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          CustomText(
                            title: item['label']!,
                            textSize: 13.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            textColor: isSelected
                                ? ConstColor.primaryColor
                                : ConstColor.textColor,
                            maxLine: 1,
                          ),
                          if (isSelected) ...[
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.check,
                              size: 13.sp,
                              color: ConstColor.primaryColor,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: () => Get.back(),
              height: 48,
              top: 0,
              buttonBorderRadius: 30,
              gradient: const [
                ConstColor.primaryDeepColor,
                ConstColor.primaryColor,
              ],
              child: CustomText(
                title: ConstString.done,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

// ── Helpers ──
class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) => CustomText(
    title: text,
    textSize: 13.sp,
    fontWeight: FontWeight.w500,
    textColor: ConstColor.grey,
    maxLine: 1,
  );
}

class _Chip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _Chip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: ConstColor.primaryColor.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: label,
            textSize: 13.sp,
            fontWeight: FontWeight.w500,
            textColor: ConstColor.primaryColor,
            maxLine: 1,
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 14.sp,
              color: ConstColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final Map<String, String> item;

  const _InterestChip({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            item['icon']!,
            width: 14.r,
            height: 14.r,
            colorFilter: const ColorFilter.mode(
              ConstColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 6.w),
          CustomText(
            title: item['label']!,
            textSize: 13.sp,
            fontWeight: FontWeight.w500,
            textColor: ConstColor.textColor,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const _Dropdown({
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value?.isEmpty ?? true ? null : value,
          dropdownColor: Colors.white,
          hint: CustomText(
            title: hint,
            textSize: 14.sp,
            textColor: ConstColor.grey,
            maxLine: 1,
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ConstColor.grey,
            size: 22.sp,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: CustomText(
                    title: e,
                    textSize: 14.sp,
                    textColor: ConstColor.black,
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
