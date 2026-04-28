import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/phone_login_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhoneLoginController>();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppImage(
              path: 'assets/images/auth_img.jpg',
              width: double.infinity,
              height: 410.h,
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.0, 0.19, 0.50, 1.0],
                  colors: [
                    Color(0xBB000000),
                    Color(0x66000000),
                    Color(0x1A6C5CE7),
                    Color(0xFF211A58),
                    Color(0xFF211A58),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(
                bottom: keyboardHeight > 0 ? keyboardHeight + 16.h : 0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Form(
                      key: controller.phoneFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ---- Logo ----
                          Image.asset(
                            "assets/images/app_logo.png",
                            width: 38.w,
                            height: 50.h,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            title: ConstString.continueWithPhoneTitle,
                            textColor: ConstColor.black,
                            textSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                          ),
                          SizedBox(height: 6.h),

                          // ---- Subtitle ----
                          CustomText(
                            title: ConstString.noWorries,
                            textColor: ConstColor.grey,
                            textSize: 15.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 17.h),

                          // ---- Phone Number Field ----
                          CustomTextFormField(
                            fromTitle: ConstString.phoneNumber,
                            hintText: CustomText(
                              title: ConstString.enterPhoneNumber,
                              textColor: const Color(0xFF94A3B8),
                              textSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              maxLine: 1,
                            ),
                            textController: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            numeric: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: SvgPicture.asset(
                                'assets/icons/call_end.svg',
                                width: 25.w,
                                height: 25.h,
                                colorFilter: const ColorFilter.mode(
                                  ConstColor.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            borderRadius: 90,
                            backgroundColor: const Color(0xFFF2F4F6),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),

                          // ---- Send OTP Button ----
                          Obx(
                                () => CustomElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.sendOtp,
                              height: 54,
                              top: 0,
                              buttonBorderRadius: 30,
                              gradient: const [
                                ConstColor.primaryDeepColor,
                                ConstColor.primaryColor,
                              ],
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                                  : CustomText(
                                title: ConstString.sendOtp,
                                textColor: Colors.white,
                                textSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                maxLine: 1,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // ---- Back to Sign Up ----
                          GestureDetector(
                            onTap: controller.goBack,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_back),
                                SizedBox(width: 4.w),
                                CustomText(
                                  title: ConstString.backToSignUp,
                                  textColor: ConstColor.black,
                                  textSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.center,
                                  maxLine: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}