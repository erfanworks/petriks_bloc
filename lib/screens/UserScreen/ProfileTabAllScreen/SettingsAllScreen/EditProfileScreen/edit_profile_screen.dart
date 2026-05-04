import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

import 'Controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.editProfile, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  _FieldLabel(ConstString.fullName),
                  SizedBox(height: 6.h),
                  _InputTile(
                    icon: Icons.person_outline_rounded,
                    ctrl: c.fullNameController,
                  ),
                  SizedBox(height: 16.h),

                  // Date of Birth
                  _FieldLabel(ConstString.dateOfBirth),
                  SizedBox(height: 6.h),
                  Obx(
                    () => _ReadonlyTile(
                      icon: Icons.calendar_today_outlined,
                      value: c.dateOfBirth.value,
                      onTap: () => c.onDateOfBirthTap(context),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Age Band
                  _FieldLabel(ConstString.selectAgeBand),
                  SizedBox(height: 10.h),
                  _AgeBandGrid(c: c),
                  SizedBox(height: 16.h),

                  // Location
                  _FieldLabel(ConstString.confirmArea),
                  SizedBox(height: 6.h),
                  _SearchField(c: c),
                  SizedBox(height: 10.h),
                  _MapPlaceholder(),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        size: 14.sp,
                        color: ConstColor.primaryColor,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Obx(
                          () => CustomText(
                            title: c.locationLabel.value,
                            textSize: 12.sp,
                            textColor: ConstColor.grey,
                            maxLine: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
          _SaveBtn(c: c),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: text,
      textSize: 14.sp,
      fontWeight: FontWeight.w600,
      textColor: ConstColor.black,
      maxLine: 1,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );
  }
}

class _InputTile extends StatelessWidget {
  final IconData icon;
  final TextEditingController ctrl;

  const _InputTile({required this.icon, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ConstColor.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: ConstColor.textColor),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: ctrl,
              style: TextStyle(
                fontSize: 14.sp,
                color: ConstColor.black,
                fontFamily: 'Roboto',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              cursorColor: ConstColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadonlyTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final VoidCallback onTap;

  const _ReadonlyTile({
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: ConstColor.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: ConstColor.textColor),
            SizedBox(width: 10.w),
            CustomText(
              title: value,
              textSize: 14.sp,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _AgeBandGrid extends StatelessWidget {
  final EditProfileController c;

  const _AgeBandGrid({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 3.2,
        children: c.ageBands.map((band) {
          final selected = c.selectedAgeBand.value == band;
          return GestureDetector(
            onTap: () => c.onAgeBandSelected(band),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: selected
                    ? ConstColor.primaryColor
                    : ConstColor.black.withAlpha(10),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Center(
                child: CustomText(
                  title: band,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  textColor: selected ? ConstColor.white : ConstColor.grey,
                  maxLine: 1,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final EditProfileController c;

  const _SearchField({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ConstColor.black.withAlpha(10),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 18.sp, color: ConstColor.grey),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: c.searchLocationCtrl,
              style: TextStyle(
                fontSize: 14.sp,
                color: ConstColor.black,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                hintText: ConstString.searchLocation,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ConstColor.grey,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              cursorColor: ConstColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: AppImage(
            path: 'assets/images/map_img.png',
            width: double.infinity,
            height: 160.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Icon(
              Icons.location_pin,
              size: 36.sp,
              color: ConstColor.primaryColor,
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          right: 10.w,
          child: Container(
            width: 34.w,
            height: 34.h,
            decoration: BoxDecoration(
              color: ConstColor.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 6),
              ],
            ),
            child: Icon(
              Icons.my_location_rounded,
              size: 16.sp,
              color: ConstColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _SaveBtn extends StatelessWidget {
  final EditProfileController c;

  const _SaveBtn({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        5.h + MediaQuery.of(context).padding.bottom,
      ),
      color: ConstColor.white,
      child: Obx(
        () => CustomElevatedButton(
          onPressed: c.isSaving.value ? null : c.onSave,
          height: 52,
          top: 0,
          buttonBorderRadius: 30,
          child: c.isSaving.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    color: ConstColor.white,
                    strokeWidth: 2,
                  ),
                )
              : CustomText(
                  title: ConstString.save,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.white,
                  maxLine: 1,
                ),
        ),
      ),
    );
  }
}
