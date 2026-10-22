import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/CoverRatioHint/cover_ratio_hint.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_competition_controller.dart';
import 'Widget/add_custom_match_location_sheet.dart';

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
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),

            SizedBox(height: 20.h),

            CustomText(
              title: ConstString.uploadAImage,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),

            Obx(() {
              final hasImage = c.uploadImage.value.isNotEmpty;

              return GestureDetector(
                onTap: hasImage ? null : c.pickDescriptionPhoto,
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
                            File(c.uploadImage.value),
                            fit: BoxFit.contain,
                          ),
                        ),

                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: GestureDetector(
                            onTap: c.pickDescriptionPhoto,
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
                          width: 50.r,
                          height: 50.r,
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
                              width: 18.r,
                              height: 18.r,
                              colorFilter: const ColorFilter.mode(
                                ConstColor.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          title: ConstString.recommendedImageQuality,
                          textSize: 10.sp,
                          textColor: ConstColor.iconColor,
                          textAlign: TextAlign.center,
                          maxLine: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const CoverRatioHint(ratio: '9:4', size: '1200 × 533 px'),
            SizedBox(height: 16.h),
            CustomText(
              title: ConstString.competitionTitle,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ConstColor.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined,
                      color: ConstColor.primaryColor, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: c.titleController,
                      maxLength: 60,
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        counterText: '',
                        hintText: 'Enter competition title',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // ---- Recommended Partner Places ----
            CustomText(
              title: ConstString.recommendedPartnerPlaces,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),

            Obx(
                  () => SizedBox(
                height: 260.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: c.matchLocations.length,
                  separatorBuilder: (_, _) => SizedBox(width: 12.w),
                  itemBuilder: (context, i) {
                    final loc = c.matchLocations[i];
                    final String name = loc['name'] ?? '';

                    return Obx(() {
                      final selected = c.selectedMatchLocationNames.contains(name);
                      final isCustom = loc['isCustom'] == 'true';

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: selected ? ConstColor.primaryColor : ConstColor.borderColor,
                            width: selected ? 1.8 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                              child: Stack(
                                children: [
                                  AppImage(
                                    path: isCustom ? null : loc['image'],
                                    filePath: isCustom ? loc['image'] : null,
                                    width: double.infinity,
                                    height: 120.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Positioned(
                                    top: 10.h,
                                    left: 10.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: isCustom ? ConstColor.primaryColor : const Color(0xFFB35A00),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (isCustom) ...[
                                            Icon(Icons.person_pin_circle_rounded, size: 11.sp, color: Colors.white),
                                            SizedBox(width: 3.w),
                                          ],
                                          CustomText(
                                            title: isCustom ? ConstString.addedByYou : loc['discount']!,
                                            textSize: 9.sp,
                                            fontWeight: FontWeight.w600,
                                            textColor: Colors.white,
                                            maxLine: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: name,
                                    textSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: ConstColor.black,
                                    maxLine: 1,
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 12.sp, color: ConstColor.primaryColor),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: CustomText(
                                          title: loc['sub']!,
                                          textSize: 11.sp,
                                          textColor: ConstColor.primaryColor,
                                          maxLine: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (loc['desc']!.isNotEmpty) ...[
                                    SizedBox(height: 3.h),
                                    CustomText(
                                      title: loc['desc']!,
                                      textSize: 11.sp,
                                      textColor: ConstColor.grey,
                                      maxLine: 2,
                                    ),
                                  ],
                                  SizedBox(height: 8.h),
                                  GestureDetector(
                                    onTap: () => c.toggleMatchLocation(name),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 9.h),
                                      decoration: BoxDecoration(
                                        color: selected ? ConstColor.primaryColor : Colors.transparent,
                                        borderRadius: BorderRadius.circular(30.r),
                                        border: Border.all(color: ConstColor.primaryColor),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          title: selected ? ConstString.selected : ConstString.useThisVenue,
                                          textSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          textColor: selected ? Colors.white : ConstColor.primaryColor,
                                          maxLine: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 8.h),

            GestureDetector(
              onTap: showAddCustomMatchLocationSheet,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ConstColor.borderColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: CustomText(
                    title: ConstString.addCustomLocation,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),

            Obx(() {
              if (!c.showMatchPlaceVoting) return const SizedBox.shrink();
              return Container(
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F8E9),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: const Color(0xFF2E7D32).withAlpha(60)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.how_to_vote_outlined, color: const Color(0xFF2E7D32), size: 20.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: ConstString.peopleMayVoteForPlace,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            textColor: const Color(0xFF2E7D32),
                            maxLine: 1,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            title: ConstString.peopleMayVoteForPlaceDesc(c.selectedMatchLocationNames.length),
                            textSize: 12.sp,
                            textColor: ConstColor.textColor,
                            maxLine: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 16.h),

            _VoteDurationSection(),

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
              title: ConstString.matchStart,
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

            // ---- Player Capacity ----
            CustomText(
              title: ConstString.playerCapacity,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ConstColor.borderColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.group_outlined,
                      color: ConstColor.primaryColor, size: 20.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: c.capacityController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ConstColor.black,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: '5',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

// ---- Registration Deadline ----
            CustomText(
              title: ConstString.registrationDeadline,
              textColor: ConstColor.black,
              textSize: 15.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
            SizedBox(height: 4.h),
            CustomText(
              title: ConstString.registrationDeadlineSubtitle,
              textColor: ConstColor.iconColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
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
                controller: c.descriptionController,
                maxLines: 8,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ConstColor.textColor,
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
      bottomNavigationBar: Obx(() {
        final isValid = c.isStep3Valid;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            4.h + MediaQuery.of(context).padding.bottom,
          ),
          child: CustomElevatedButton(
            onPressed: c.goToFinalReview,
            height: 48,
            top: 0,
            buttonBorderRadius: 30,
            gradient: isValid
                ? const [ConstColor.primaryDeepColor, ConstColor.primaryColor]
                : [
                    ConstColor.primaryColor.withAlpha(100),
                    ConstColor.primaryColor.withAlpha(100)
                  ],
            child: CustomText(
              title: ConstString.saveAndContinue,
              textColor: Colors.white,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _VoteDurationSection extends StatelessWidget {
  const _VoteDurationSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              width: 34.r,
              height: 34.r,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.timer_outlined, size: 18.sp, color: ConstColor.primaryColor),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.voteDuration,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: ConstString.voteDurationSubtitle,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Duration Chips + Custom
        Obx(() => Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // Fixed duration chips
            ...c.voteDurations.asMap().entries.map((entry) {
              final isSelected = c.voteDurationIndex.value == entry.key;
              return GestureDetector(
                onTap: () => c.voteDurationIndex.value = entry.key,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
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
                      if (isSelected) ...[
                        Icon(Icons.check_rounded, size: 13.sp, color: Colors.white),
                        SizedBox(width: 4.w),
                      ],
                      CustomText(
                        title: entry.value,
                        textSize: 13.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        textColor: isSelected ? Colors.white : ConstColor.black,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Custom chip — clock picker
            _CustomDurationChip(c: c, context: context),
          ],
        )),

        SizedBox(height: 10.h),

        //  Info pill
        Obx(() {
          final isCustom  = c.voteDurationIndex.value == 99;
          final duration  = isCustom
              ? (c.customDuration.value.isEmpty ? 'custom time' : c.customDuration.value)
              : c.voteDurations[c.voteDurationIndex.value];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ConstColor.primaryColor.withAlpha(40)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 15.sp, color: ConstColor.primaryColor),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    title: 'Voting will close after $duration — then the most voted option wins.',
                    textSize: 12.sp,
                    textColor: ConstColor.primaryColor,
                    maxLine: 2,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// Custom Duration Chip
class _CustomDurationChip extends StatelessWidget {
  final CreateCompetitionController c;
  final BuildContext context;
  const _CustomDurationChip({required this.c, required this.context});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = c.voteDurationIndex.value == 99;
      return GestureDetector(
        onTap: () {
          c.voteDurationIndex.value = 99;
          c.onPickCustomDuration(context);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
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
              Icon(
                Icons.access_time_rounded,
                size: 13.sp,
                color: isSelected ? Colors.white : ConstColor.primaryColor,
              ),
              SizedBox(width: 4.w),
              CustomText(
                title: c.customDuration.value.isEmpty ? 'Custom' : c.customDuration.value,
                textSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                textColor: isSelected ? Colors.white : ConstColor.black,
                maxLine: 1,
              ),
            ],
          ),
        ),
      );
    });
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