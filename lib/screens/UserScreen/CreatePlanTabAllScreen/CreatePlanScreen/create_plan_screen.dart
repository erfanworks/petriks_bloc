import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/create_plan_controller.dart';
import 'Widget/cover_photo_uploader.dart';
import 'Widget/show_add_custom_location_sheet.dart';

class CreatePlanScreen extends StatelessWidget {
  const CreatePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.createPlan,
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
            child: Obx(() {
              if (c.currentStep.value == 0) {
                return const _Step1PlanType();
              }

              if (c.selectedPlanType.value == 'Group Plan') {
                if (c.currentStep.value == 1) return const _Step2Activity();
                if (c.currentStep.value == 2) return const _Step3Vibe();
                if (c.currentStep.value == 3) return const _Step4WhenWhere();
              } else {
                if (c.currentStep.value == 1) return const _Step3Vibe();
                if (c.currentStep.value == 2) return const _Step4WhenWhere();
              }

              return const SizedBox.shrink();
            }),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              0,
              16.w,
              5.h + MediaQuery.of(context).padding.bottom,
            ),
            child: Obx(() {
              final isNextDisabled = !c.canProceed;

              return CustomElevatedButton(
                height: 48,
                top: 0,
                onPressed: isNextDisabled ? () {} : c.nextStep,
                gradient: isNextDisabled
                    ? [Colors.grey.shade400, Colors.grey.shade400]
                    : [ConstColor.primaryDeepColor, ConstColor.primaryColor],
                buttonBorderRadius: 30,
                child: CustomText(
                  title: c.buttonLabel,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w600,
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

class _Step1PlanType extends StatelessWidget {
  const _Step1PlanType();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepTitle(title: ConstString.whatDoYouWantToDo),
          SizedBox(height: 16.h),
          Obx(
            () => Column(
              children: c.planTypes.map((pt) {
                final selected = c.selectedPlanType.value == pt['label'];
                return GestureDetector(
                  onTap: () => c.selectedPlanType.value = pt['label'] as String,
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
                                color: pt['bgColor'] as Color,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  pt['icon'] as String,
                                  width: 22.r,
                                  height: 22.r,
                                  colorFilter: ColorFilter.mode(
                                    pt['iconColor'] as Color,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: pt['tagBg'] as Color,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: (pt['tagColor'] as Color).withAlpha(
                                    80,
                                  ),
                                ),
                              ),
                              child: CustomText(
                                title: pt['tag'] as String,
                                textSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                textColor: pt['tagColor'] as Color,
                                maxLine: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          title: pt['label'] as String,
                          textSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.black,
                          maxLine: 1,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          title: pt['desc'] as String,
                          textSize: 15.sp,
                          textColor: ConstColor.grey,
                          fontWeight: FontWeight.w500,
                          maxLine: 3,
                        ),
                        if (pt['showArrow'] == true) ...[
                          SizedBox(height: 8.h),
                          CustomText(
                            title: ConstString.letsGo,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.primaryColor,
                            maxLine: 1,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Step 2
class _Step2Activity extends StatelessWidget {
  const _Step2Activity();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepTitle(title: ConstString.pickAnActivity),
          SizedBox(height: 16.h),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.1,
              children: c.activities.map((act) {
                final selected = c.selectedActivity.value == act['label'];
                return GestureDetector(
                  onTap: () => c.selectedActivity.value = act['label']!,
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
                              act['icon']!,
                              width: 24.r,
                              height: 24.r,
                              colorFilter: ColorFilter.mode(
                                selected
                                    ? ConstColor.primaryColor
                                    : ConstColor.textColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          title: act['label']!,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          textColor: ConstColor.black,
                          textAlign: TextAlign.center,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Step 3
class _Step3Vibe extends StatelessWidget {
  const _Step3Vibe();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepTitle(title: ConstString.whatsTheVibe),
          SizedBox(height: 14.h),

          Obx(
            () => Wrap(
              alignment: WrapAlignment.start,
              spacing: 40.w,
              runSpacing: 8.h,
              children: c.vibes.map((v) {
                final sel = c.selectedVibe.value == v;
                return _SelectChip(
                  label: v,
                  selected: sel,
                  onTap: () => c.selectedVibe.value = v,
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 16.h),

          // _FieldLabel(label: ConstString.groupSize),
          // SizedBox(height: 8.h),
          // Obx(
          //   () => _PillRow(
          //     items: c.groupSizes,
          //     selected: c.selectedGroupSize.value,
          //     onTap: (v) => c.selectedGroupSize.value = v,
          //   ),
          // ),
          //
          // SizedBox(height: 16.h),
          Obx(() => c.selectedPlanType.value == 'Group Plan'
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(label: ConstString.groupSize),
              SizedBox(height: 8.h),
              Obx(() => _PillRow(
                items: c.groupSizes,
                selected: c.selectedGroupSize.value,
                onTap: (v) => c.selectedGroupSize.value = v,
              )),
              SizedBox(height: 16.h),
            ],
          )
              : const SizedBox.shrink(),
          ),

          // Budget
          _FieldLabel(label: ConstString.budget),
          SizedBox(height: 8.h),
          Obx(
            () => _PillRow(
              items: c.budgets,
              selected: c.selectedBudget.value,
              onTap: (v) => c.selectedBudget.value = v,
            ),
          ),

          SizedBox(height: 16.h),

          _FieldLabel(label: ConstString.gender),
          SizedBox(height: 8.h),
          Obx(
            () => _DropdownBox(
              hint: ConstString.selectGender,
              value: c.selectedGender.value.isEmpty
                  ? null
                  : c.selectedGender.value,
              items: c.genders,
              onChanged: (v) => c.selectedGender.value = v ?? '',
            ),
          ),

          SizedBox(height: 16.h),

          // Age band
          _FieldLabel(label: ConstString.selectYourAgeBand),
          SizedBox(height: 8.h),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 3.0,
              children: c.ageBands.map((band) {
                final sel = c.selectedAgeBand.value == band;
                return GestureDetector(
                  onTap: () => c.selectedAgeBand.value = band,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    decoration: BoxDecoration(
                      color: sel
                          ? ConstColor.primaryColor
                          : ConstColor.boxColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: sel
                            ? ConstColor.primaryColor
                            : ConstColor.borderColor,
                      ),
                    ),
                    child: Center(
                      child: CustomText(
                        title: band,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textColor: sel ? Colors.white : ConstColor.black,
                        maxLine: 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 16.h),

          _FieldLabel(label: ConstString.language),
          SizedBox(height: 8.h),
          Obx(
            () => _DropdownBox(
              hint: ConstString.selectLanguage,
              value: c.selectedLanguage.value.isEmpty
                  ? null
                  : c.selectedLanguage.value,
              items: c.languages,
              onChanged: (v) => c.selectedLanguage.value = v ?? '',
            ),
          ),

          SizedBox(height: 12.h),
          CustomTextFormField(
            borderRadius: 12,
            backgroundColor: ConstColor.white,
            fromTitle: ConstString.languageNotListed,
            textController: c.customLanguageController,
            hintText: const SizedBox.shrink(),
          ),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

// Step 4
class _Step4WhenWhere extends StatelessWidget {
  const _Step4WhenWhere();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepTitle(title: ConstString.whenShouldItHappen),
          SizedBox(height: 16.h),

          CoverPhotoUploader(coverPhotoPath: c.coverPhotoPath),
          SizedBox(height: 16.h),
          // Plan Title
          CustomTextFormField(
            backgroundColor: ConstColor.white,
            fromTitle: ConstString.planTitle,
            textController: c.planTitleController,
            hintText: const SizedBox.shrink(),
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
            suffixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ConstColor.iconColor,
                size: 20.r,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          Obx(
            () => _DropdownField(
              label: ConstString.selectDate,
              value: c.selectedDate.value,
              icon: 'assets/icons/calender_icon.svg',
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (ctx, child) => Theme(
                    data: Theme.of(ctx).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: ConstColor.primaryColor,
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) c.onDateSelected(picked);
              },
            ),
          ),

          SizedBox(height: 8.h),

          _FieldLabel(label: ConstString.selectTime),
          SizedBox(height: 6.h),
          Obx(
                () => _DropdownField(
              value: c.selectedTime1.value,
              icon: 'assets/icons/clock_icon.svg',
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (ctx, child) => Theme(
                    data: Theme.of(ctx).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: ConstColor.primaryColor,
                      ),
                    ),
                    child: child!,
                  ),
                );
                if (picked != null) c.onTimeSelected(picked);
              },
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: ConstColor.primaryColor,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    title: ConstString.itIsBestToSetTheVoting,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                    maxLine: 5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          Obx(
                () => _ToggleCard(
              icon: Icons.list_alt_rounded,
              title: ConstString.letPeopleVoteTime,
              subtitle: ConstString.voteTimeSubtitle,
              value: c.voteOnTime.value,
              onChanged: (v) => c.voteOnTime.value = v,
            ),
          ),


          SizedBox(height: 8.h),
          Obx(() => Opacity(
            opacity: c.voteOnTime.value ? 1.0 : 0.4,
            child: IgnorePointer(
              ignoring: !c.voteOnTime.value,
              child: _DropdownField(
                value: c.selectedTime2.value,
                icon: 'assets/icons/clock_icon.svg',
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (ctx, child) => Theme(
                      data: Theme.of(ctx).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: ConstColor.primaryColor,
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) c.onTime2Selected(picked);
                },
              ),
            ),
          )),


          SizedBox(height: 16.h),




          _FieldLabel(label: ConstString.recommendedPartnerPlaces),
          SizedBox(height: 12.h),

          Obx(
                () => SizedBox(
              height: 310.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: c.locations.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, i) {
                  final loc = c.locations[i];
                  final String name = loc['name'] ?? '';

                  return Obx(() {
                    final selected = c.selectedLocationNames.contains(name);
                    final isCustom = loc['isCustom'] == 'true';

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 260.w,
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
                                  height: 150.h,
                                  fit: BoxFit.cover,
                                ),

                                // ── Badge: discount (admin) OR "Added by you" (custom) ──
                                Positioned(
                                  top: 10.h,
                                  left: 10.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: isCustom ? ConstColor.primaryColor : const Color(0xFFB35A00),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isCustom) ...[
                                          Icon(Icons.person_pin_circle_rounded, size: 12.sp, color: Colors.white),
                                          SizedBox(width: 3.w),
                                        ],
                                        CustomText(
                                          title: isCustom ? ConstString.addedByYou : loc['discount']!,
                                          textSize: 10.sp,
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
                            padding: EdgeInsets.all(12.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: name,
                                  textSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: ConstColor.black,
                                  maxLine: 1,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 14.sp, color: ConstColor.textColor),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: CustomText(
                                        title: loc['sub']!,
                                        textSize: 12.sp,
                                        textColor: ConstColor.textColor,
                                        maxLine: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                if (loc['desc']!.isNotEmpty) ...[
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    title: loc['desc']!,
                                    textSize: 12.sp,
                                    textColor: ConstColor.grey,
                                    maxLine: 2,
                                  ),
                                ],
                                SizedBox(height: 10.h),
                                GestureDetector(
                                  onTap: () => c.toggleLocation(name),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 11.h),
                                    decoration: BoxDecoration(
                                      color: selected ? ConstColor.primaryColor : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(color: ConstColor.primaryColor),
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        title: selected ? ConstString.selected : ConstString.useThisVenue,
                                        textSize: 14.sp,
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
            onTap: showAddCustomLocationSheet,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.h, bottom: 15.h),
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
                  textSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textColor: ConstColor.textColor,
                  maxLine: 1,
                ),
              ),
            ),
          ),
          const PlaceVotingSection(),


        //   SizedBox(height: 16.h),
        //
        //   _FieldLabel(label: ConstString.voteLockSettings),
        //   SizedBox(height: 8.h),
        //   Obx(
        //     () => _ToggleCard(
        //       icon: Icons.lock_outline,
        //       title: ConstString.enableAutoLock,
        //       value: c.autoLock.value,
        //       onChanged: (v) => c.autoLock.value = v,
        //     ),
        //   ),
        //   SizedBox(height: 8.h),
        //
        //   _FieldLabel(label: ConstString.setTime),
        // SizedBox(height: 6.h),
        // Obx(
        //       () => GestureDetector(
        //     onTap: () async {
        //       final picked = await showTimePicker(
        //         context: context,
        //         initialTime: TimeOfDay.now(),
        //         builder: (ctx, child) => Theme(
        //           data: Theme.of(ctx).copyWith(
        //             colorScheme: const ColorScheme.light(
        //               primary: ConstColor.primaryColor,
        //             ),
        //           ),
        //           child: child!,
        //         ),
        //       );
        //       if (picked != null) c.onAutoLockTimeSelected(picked);
        //     },
        //     child: Container(
        //       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
        //       decoration: BoxDecoration(
        //         color: ConstColor.boxColor,
        //         borderRadius: BorderRadius.circular(12.r),
        //         border: Border.all(color: ConstColor.borderColor),
        //       ),
        //       child: Row(
        //         children: [
        //           SvgPicture.asset(
        //             'assets/icons/clock_icon.svg',
        //             width: 16.r,
        //             height: 16.r,
        //             colorFilter: const ColorFilter.mode(
        //               ConstColor.primaryColor,
        //               BlendMode.srcIn,
        //             ),
        //           ),
        //           SizedBox(width: 8.w),
        //           Expanded(
        //             child: CustomText(
        //               title: c.autoLockTime.value,
        //               textSize: 16.sp,
        //               textColor: ConstColor.black,
        //               maxLine: 1,
        //             ),
        //           ),
        //           Icon(Icons.edit_outlined, size: 18.r, color: ConstColor.black),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
          SizedBox(height: 14.h),
          _VoteDurationSection(),




          SizedBox(height: 14.h),
          Obx(
            () => PrivacySection(
              selectedPrivacy: c.selectedPrivacy.value,
              onPrivacyChanged: (val) => c.selectedPrivacy.value = val,
              // onAddCustomLocation: () {},
            ),
          ),
          SizedBox(height: 14.h),

          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              border: Border.all(
                color: ConstColor.primaryColor.withAlpha(40),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/stay_safe_icon.svg',
                  width: 22.r,
                  height: 22.r,
                  colorFilter: const ColorFilter.mode(
                    ConstColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: ConstString.staySafe,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        textColor: const Color(0xFF1E3A8A),
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        title: ConstString.staySafeSubtitle,
                        textSize: 14.sp,
                        textColor: ConstColor.primaryColor,
                        maxLine: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class PlaceVotingSection extends StatelessWidget {
  const PlaceVotingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

    return Obx(() {
      if (!c.showPlaceVoting) return const SizedBox.shrink();

      final selectedLocs = c.selectedLocationNames.toList()..sort();

      return Container(
        margin: EdgeInsets.only(top: 16.h),
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
                    title: ConstString.peopleMayVoteForPlaceDesc(selectedLocs.length),
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
    });
  }
}


class _VoteDurationSection extends StatelessWidget {
  const _VoteDurationSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreatePlanController>();

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
  final CreatePlanController c;
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

class PrivacySection extends StatelessWidget {
  final String selectedPrivacy;
  final ValueChanged<String> onPrivacyChanged;
  // final VoidCallback onAddCustomLocation;

  const PrivacySection({
    super.key,
    required this.selectedPrivacy,
    required this.onPrivacyChanged,
    // required this.onAddCustomLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: ConstString.privacy,
          textSize: 16.sp,
          fontWeight: FontWeight.w700,
          textColor: ConstColor.black,
          maxLine: 1,
        ),
        SizedBox(height: 12.h),

        _PrivacyOption(
          icon: Icons.public_rounded,
          title: ConstString.publicLabel,
          subtitle: ConstString.publicDesc,
          isSelected: selectedPrivacy == 'public',
          onTap: () => onPrivacyChanged('public'),
        ),
        SizedBox(height: 10.h),

        _PrivacyOption(
          icon: Icons.lock_outline_rounded,
          title: ConstString.privateLabel,
          subtitle: ConstString.privateDesc,
          isSelected: selectedPrivacy == 'private',
          onTap: () => onPrivacyChanged('private'),
        ),
      ],
    );
  }
}

class _PrivacyOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PrivacyOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: ConstColor.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? ConstColor.primaryColor
                : ConstColor.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon circle
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, size: 18.sp, color: ConstColor.primaryColor),
              ),
            ),
            SizedBox(width: 12.w),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: subtitle,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 3,
                  ),
                ],
              ),
            ),

            // Check icon when selected
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Container(
                width: 22.r,
                height: 22.r,
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: ConstColor.white,
                  size: 13.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => CustomText(
    title: title,
    textSize: 24.sp,
    fontWeight: FontWeight.w700,
    textColor: ConstColor.black,
    maxLine: 2,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => CustomText(
    title: label,
    textSize: 16.sp,
    fontWeight: FontWeight.w600,
    textColor: ConstColor.black,
    maxLine: 1,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
  );
}

class _SelectChip extends StatelessWidget {
  const _SelectChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: selected ? ConstColor.primaryColor : ConstColor.boxColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: selected ? ConstColor.primaryColor : ConstColor.borderColor,
        ),
      ),
      child: CustomText(
        title: label,
        textSize: 16.sp,
        fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
        textColor: selected ? Colors.white : ConstColor.black,
        maxLine: 1,
      ),
    ),
  );
}

class _PillRow extends StatelessWidget {
  const _PillRow({
    required this.items,
    required this.selected,
    required this.onTap,
  });

  final List<String> items;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(4.r),
    decoration: BoxDecoration(
      color: ConstColor.black.withAlpha(20),
      borderRadius: BorderRadius.circular(30.r),
    ),
    child: Row(
      children: items.map((item) {
        final sel = selected == item;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: sel ? ConstColor.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Center(
                child: CustomText(
                  title: item,
                  textSize: 14.sp,
                  fontWeight: sel ? FontWeight.w500 : FontWeight.w400,
                  textColor: sel ? Colors.white : ConstColor.black,
                  maxLine: 1,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

class _DropdownBox extends StatelessWidget {
  const _DropdownBox({
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
  Widget build(BuildContext context) => Container(
    height: 50.h,
    padding: EdgeInsets.symmetric(horizontal: 14.w),
    decoration: BoxDecoration(
      color: ConstColor.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ConstColor.borderColor),
    ),
    child: DropdownButtonHideUnderline(
      child: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: Colors.grey,
          focusColor: Colors.black.withAlpha(20),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: Colors.white,
        ),
        child: DropdownButton<String>(
          value: value,
          hint: CustomText(
            title: hint,
            textSize: 13.sp,
            textColor: ConstColor.iconColor,
            maxLine: 1,
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ConstColor.textColor,
            size: 20.r,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: CustomText(
                    title: e,
                    textSize: 13.sp,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    ),
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null) ...[_FieldLabel(label: label!), SizedBox(height: 6.h)],
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
                  textSize: 15.sp,
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

class _ToggleCard extends StatelessWidget {
  const _ToggleCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
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
          width: 39.r,
          height: 39.r,
          decoration: BoxDecoration(
            color: ConstColor.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.r, color: ConstColor.primaryColor),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              if (subtitle != null)
                CustomText(
                  title: subtitle!,
                  textSize: 13.sp,
                  textColor: ConstColor.grey,
                  maxLine: 2,
                  fontWeight: FontWeight.w500,
                ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: ConstColor.primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    ),
  );
}
