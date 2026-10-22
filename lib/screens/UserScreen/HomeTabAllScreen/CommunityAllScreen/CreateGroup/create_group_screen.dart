import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/utils/app_size.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/create_group_controller.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late final CreateGroupController c;

  @override
  void initState() {
    super.initState();
    // Use Get.find if it's already in bindings, otherwise Get.put
    try {
      c = Get.find<CreateGroupController>();
    } catch (e) {
      c = Get.put(CreateGroupController());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: GlobalAppBar(title: ConstString.createGroup),
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StepHeader(
                title: ConstString.groupInformation,
                subtitle: ConstString.giveYourGroupAName,
              ),
              SizedBox(height: 16.h),

              CustomTextFormField(
                fromTitle: ConstString.groupName,
                textController: c.groupNameController,
                onChanged: (value) => c.updateGroupName(value),
                hintText: const SizedBox.shrink(),
                backgroundColor: ConstColor.white,
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
                ),
                child: TextField(
                  controller: c.descriptionController,
                  onChanged: (value) => c.updateDescription(value),
                  maxLines: 8,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: ConstColor.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        "e.g., A community for weekly football meetups, practice matches, and social hangouts in London.",
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
                title: ConstString.groupLimit,
                textSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: ConstColor.silverGray20,
                maxLine: 1,
              ),
              SizedBox(height: 10.h),
              Obx(
                () => Container(
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    color: ConstColor.black.withAlpha(30),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Row(
                    children: c.groupLimits.map((limit) {
                      final isCustomBtn = limit == "Custom";
                      final isEditing = isCustomBtn && c.showCustomInput.value;

                      final bool isPredefinedSelected =
                          !isCustomBtn && c.selectedGroupLimit.value == limit;

                      final bool isCustomSelected =
                          isCustomBtn &&
                          c.selectedGroupLimit.value ==
                              c.customLimitController.text &&
                          c.customLimitController.text.isNotEmpty;

                      final bool isCustomActive =
                          isCustomBtn && c.showCustomInput.value;

                      String displayLabel =
                          (isCustomBtn &&
                              c.customLimitController.text.isNotEmpty)
                          ? c.customLimitController.text
                          : limit;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (isCustomBtn) {
                              c.showCustomInput.value = true;
                              c.selectedGroupLimit.value = '';
                            } else {
                              c.selectGroupLimit(limit);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 00),
                            padding: EdgeInsets.symmetric(
                              vertical: isEditing ? 5.h : 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: isCustomSelected || isPredefinedSelected
                                  ? ConstColor.primaryColor
                                  : isCustomActive
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            child: Center(
                              child: isEditing
                                  ? TextField(
                                      controller: c.customLimitController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      autofocus: false,
                                      style: TextStyle(
                                        color: isCustomSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                      onSubmitted: (value) =>
                                          c.submitCustomLimit(value),
                                    )
                                  : CustomText(
                                      title: displayLabel,
                                      textSize: 13.sp,
                                      fontWeight:
                                          (isPredefinedSelected ||
                                              isCustomSelected)
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      textColor:
                                          (isPredefinedSelected ||
                                              isCustomSelected)
                                          ? Colors.white
                                          : isCustomActive
                                          ? Colors.black
                                          : ConstColor.black,
                                      maxLine: 1,
                                    ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              CustomElevatedButton(
                top: 0,
                onPressed: () => Get.toNamed(AppRoutes.inviteFriendsListScreen),
                isOutLined: true,
                elevation: 0,
                outLineColour: ConstColor.primaryColor.withAlpha(40),
                buttonBorderRadius: 30,
                child: CustomText(
                  title: ConstString.inviteFriends,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.primaryColor,
                  maxLine: 1,
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
                final hasImage = c.descriptionPhotoPath.value.isNotEmpty;

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
                                    File(c.descriptionPhotoPath.value),
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
                                        ConstColor.primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                CustomText(
                                  title: "Upload Description Photo",
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
              SizedBox(height: 30.h,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        final ready = c.canCreate;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16.w, 0, 16.w,
            4.h + MediaQuery.of(context).padding.bottom,
          ),
          child: CustomElevatedButton(
            onPressed: c.onCreateGroup,
            height: 48,
            top: 0,
            buttonBorderRadius: 30,
            gradient: ready
                ? [ConstColor.primaryDeepColor, ConstColor.primaryColor]
                : [
                    ConstColor.primaryColor.withAlpha(100),
                    ConstColor.primaryColor.withAlpha(100)
                  ],
            child: CustomText(
              title: ConstString.create,
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
