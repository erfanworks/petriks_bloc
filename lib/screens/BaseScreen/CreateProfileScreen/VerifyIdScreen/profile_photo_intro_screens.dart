import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/verify_id_controller.dart';

class ProfilePhotoScreen extends StatelessWidget {
  const ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(VerifyIdController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.addAProfilePhoto,
                    textSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: ConstString.profileWithPhotos,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.textColor,
                    maxLine: 2,
                  ),
                ],
              ),
            ),

            // Camera / preview circle
            Expanded(
              child: Center(
                child: Obx(() {
                  // ─── ERROR FIXED: Changed selectedImage to selectedPhotoImage ───
                  final file = c.selectedPhotoImage.value;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        // ─── ERROR FIXED: Changed pickFromCamera to pickPhotoFromCamera ───
                        onTap: file == null ? c.pickPhotoFromCamera : null,
                        child: Container(
                          width: 220.r,
                          height: 220.r,
                          decoration: BoxDecoration(
                            color: ConstColor.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6C5CE7).withAlpha(30),
                                blurRadius: 40.r,
                                spreadRadius: 20.r,
                              ),
                            ],
                          ),
                          child: file != null
                              ? ClipOval(
                            child: AppImage(
                              filePath: file.path,
                              width: 220.r,
                              height: 220.r,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64.r,
                                height: 64.r,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF6C5CE7),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/camera_icon.svg',
                                    width: 25.r,
                                    height: 23.r,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              CustomText(
                                title: ConstString.takeASelfie,
                                textSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                textColor: ConstColor.textColor,
                                maxLine: 1,
                              ),
                              SizedBox(height: 2.h),
                              CustomText(
                                title: ConstString.useYourCameraNow,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                textColor: ConstColor.grey,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (file != null)
                        Positioned(
                          top: 20,
                          right: 15,
                          child: GestureDetector(
                            onTap: c.pickPhotoFromCamera,
                            child: Container(
                              width: 36.r,
                              height: 36.r,
                              decoration: BoxDecoration(
                                color: ConstColor.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/edit_icon.svg',
                                  width: 16.r,
                                  height: 16.r,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GestureDetector(
                onTap: c.pickPhotoFromGallery,
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 55.r,
                        height: 55.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7).withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/gellary_icon.svg',
                            width: 22.r,
                            height: 22.r,
                            colorFilter: const ColorFilter.mode(
                                ConstColor.primaryColor, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: ConstString.uploadFromGallery,
                            textSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.textColor,
                            maxLine: 1,
                          ),
                          SizedBox(height: 2.h),
                          CustomText(
                            title: ConstString.pickFromYour,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            textColor: ConstColor.grey,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Obx(() => CustomElevatedButton(
                top: 0,
                onPressed: c.onProfilePhotoContinue,
                color: c.hasPhotoImage
                    ? ConstColor.primaryColor
                    : const Color(0xFF9E9E9E),
                buttonBorderRadius: 30,
                child: CustomText(
                  title: ConstString.continueA,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.white,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
