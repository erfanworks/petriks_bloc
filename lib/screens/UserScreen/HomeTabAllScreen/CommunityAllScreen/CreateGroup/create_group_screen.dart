import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: ConstString.createGroup),
      body: Padding(
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
              fromTitle: ConstString.communityName,
              textController: TextEditingController(),
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

            // ── Upload Cover Photo ──
            CustomText(
              title: ConstString.shortDescription,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.silverGray20,
              maxLine: 1,
            ),
            SizedBox(height: 4.h),
            // ── Short Description ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
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

            SizedBox(height: 16.h),

            // ── Upload Cover Photo ──
            CustomText(
              title: ConstString.uploadCoverPhoto,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.silverGray20,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),

            GestureDetector(
              onTap: () {
                // TODO: image picker
              },
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: ConstColor.primaryDeepColor,
                  strokeWidth: 1,
                  dashPattern: const [10, 5],
                  radius: Radius.circular(16.r),
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
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
                              offset: Offset(0, 4),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: CustomElevatedButton(
          onPressed: () {Get.back();},
          height: 48,
          top: 0,
          buttonBorderRadius: 30,
          gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.create,
            textColor: Colors.white,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      ),
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
