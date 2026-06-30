import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_community_controller.dart';

class CreateCommunityScreen  extends StatelessWidget {
  const CreateCommunityScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCommunityController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.createCommunity,
        onBack: () {
          if (c.currentStep.value > 0) {
            c.currentStep.value--;
          } else {
            Get.back();
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Obx(() {
                switch (c.currentStep.value) {
                  case 0:
                    return _Step1Category(c: c);
                  case 1:
                    return const StepLanguages();
                  case 2:
                    return _Step2Details(c: c);
                  case 3:
                    return _Step3Interests(c: c);
                  default:
                    return const SizedBox.shrink();
                }
              }),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              0,
              16.w,
              4.h + MediaQuery.of(context).padding.bottom,
            ),
            child: Obx(() {
              final isNextDisabled = !c.canProceed;

              return CustomElevatedButton(
                top: 0,
                onPressed: isNextDisabled ? () {} : c.nextStep,
                gradient: isNextDisabled
                    ? [ConstColor.primaryDeepColor.withAlpha(60),ConstColor.primaryDeepColor.withAlpha(60)]
                    : [ConstColor.primaryDeepColor, ConstColor.primaryColor],
                buttonBorderRadius: 30,
                child: CustomText(
                  title: c.buttonLabel,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                  maxLine: 1,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}


class _Step1Category extends StatelessWidget {
  const _Step1Category({required this.c});

  final CreateCommunityController c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeader(
          title: ConstString.whatAreYouCreating,
          subtitle: ConstString.chooseCategorySubtitle,
        ),
        SizedBox(height: 16.h),
        Obx(
              () => Column(
            children: c.categories.map((cat) {
              final selected = c.selectedCategory.value == cat['label'];
              return GestureDetector(
                onTap: () => c.selectCategory(cat['label'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: selected
                          ? ConstColor.primaryColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 56.r,
                            height: 56.r,
                            decoration: BoxDecoration(
                              color: cat['bgColor'] as Color,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                cat['icon'] as String,
                                width: 20.r,
                                height: 20.r,
                                colorFilter: ColorFilter.mode(
                                  cat['iconColor'] as Color,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          if ((cat['tag'] as String).isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5F4FF),
                                borderRadius: BorderRadius.circular(19.r),
                              ),
                              child: CustomText(
                                title: cat['tag'] as String,
                                textSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                textColor: ConstColor.blue,
                                maxLine: 1,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        title: cat['label'] as String,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.black,
                        maxLine: 1,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: cat['desc'] as String,
                        textSize: 14.sp,
                        textColor: ConstColor.iconColor,
                        fontWeight: FontWeight.w500,
                        maxLine: 3,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}



class StepLanguages extends StatelessWidget {
  const StepLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCommunityController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeader(
          title: ConstString.whatLanguageTo,
          subtitle: ConstString.thisHelpsYouConnect,
        ),
        SizedBox(height: 16.h),
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
          numeric: true,
          onChanged: (val) {
            if (val.trim().isNotEmpty) {
              c.selectedLanguages.add('custom');
            } else {
              c.selectedLanguages.remove('custom');
            }
          },
        ),
      ],
    );
  }
}




class _Step2Details extends StatelessWidget {
  const _Step2Details({required this.c});

  final CreateCommunityController c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeader(
          title: ConstString.describeYourCommunity,
          subtitle: ConstString.describeCommunitySubtitle,
        ),
        SizedBox(height: 16.h),

        CustomTextFormField(
          fromTitle: ConstString.communityName,
          textController: c.nameController,
          hintText: const SizedBox.shrink(),
          onChanged: (val) => c.nameText.value = val,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.r),
            child: SvgPicture.asset(
              'assets/icons/edit_icon.svg',
              width: 18.r,
              height: 18.r,
              colorFilter: const ColorFilter.mode(
                ConstColor.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        SizedBox(height: 4.h),
        SizedBox(height: 16.h),

        CustomText(
          title: ConstString.shortDescription,
          textSize: 16.sp,
          fontWeight: FontWeight.w500,
          textColor: ConstColor.silverGray20,
          maxLine: 1,
        ),
        SizedBox(height: 4.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ConstColor.borderColor, width: 1)
          ),
          child: TextField(
            controller: c.descController,
            onChanged: (val) => c.descText.value = val,
            maxLines: 8,
            style: TextStyle(
              fontSize: 14.sp,
              color: ConstColor.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: "e.g., A community for weekly football meetups...",
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

        SizedBox(height: 16.h),

        CustomText(
          title: ConstString.uploadCoverPhoto,
          textSize: 16.sp,
          fontWeight: FontWeight.w500,
          textColor: ConstColor.silverGray20,
          maxLine: 1,
        ),
        SizedBox(height: 8.h),

        Obx(() {
          final hasImage = c.coverPhotoPath.value.isNotEmpty;

          return GestureDetector(
            onTap: hasImage ? null : c.pickCoverPhoto,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                color: ConstColor.primaryDeepColor,
                strokeWidth: 1,
                dashPattern: const <double>[10, 5],
                radius: Radius.circular(16.r),
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: hasImage
                    ? Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Image.file(
                        File(c.coverPhotoPath.value),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: c.pickCoverPhoto,
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: ConstColor.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        color: ConstColor.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/camera_icon.svg',
                          width: 20.r,
                          height: 20.r,
                          colorFilter: const ColorFilter.mode(
                              ConstColor.primaryColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      title: ConstString.coverPhotoHint,
                      textSize: 12.sp,
                      textColor: ConstColor.iconColor,
                      textAlign: TextAlign.center,
                      maxLine: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _Step3Interests extends StatelessWidget {
  const _Step3Interests({required this.c});

  final CreateCommunityController c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeader(
          title: ConstString.setTheInterest,
          subtitle: ConstString.setInterestSubtitle,
        ),
        SizedBox(height: 16.h),
        Obx(
              () => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.1,
            children: c.interests.map((item) {
              final selected = c.selectedInterest.value == item['label'];
              return GestureDetector(
                onTap: () => c.selectInterest(item['label']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: selected
                          ? ConstColor.primaryColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          color: selected
                              ? ConstColor.primaryColor.withAlpha(20)
                              : ConstColor.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item['icon']!,
                            width: 24.r,
                            height: 24.r,
                            colorFilter: ColorFilter.mode(
                              selected
                                  ? ConstColor.primaryColor
                                  : ConstColor.iconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                        title: item['label']!,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.black,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.title, required this.subtitle});

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          textSize: 24.sp,
          fontWeight: FontWeight.w700,
          textColor: ConstColor.black,
          maxLine: 2,
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        ),
        SizedBox(height: 6.h),
        CustomText(
          title: subtitle,
          textSize: 16.sp,
          textColor: ConstColor.iconColor,
          maxLine: 3,
        ),
      ],
    );
  }
}