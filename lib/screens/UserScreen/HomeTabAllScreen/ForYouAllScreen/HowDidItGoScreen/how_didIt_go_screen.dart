import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';

import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class HowDidItGoScreen extends StatelessWidget {
  const HowDidItGoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.howDidItGo),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.didMeetupHappen,
              textColor: ConstColor.black,
              textSize: 18.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),

            SizedBox(height: 12.h),

            Obx(
              () => Row(
                children: [
                  _MeetupHappenedCard(
                    label: ConstString.yesItWasGreat,
                    icon: Icons.check_circle_outline_rounded,
                    isSelected: controller.meetupHappened.value,
                    onTap: () => controller.meetupHappened.value = true,
                  ),
                  SizedBox(width: 12.w),
                  _MeetupHappenedCard(
                    label: ConstString.noItFellThrough,
                    icon: Icons.cancel_outlined,
                    isSelected: !controller.meetupHappened.value,
                    onTap: () => controller.meetupHappened.value = false,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            CustomText(
              title: ConstString.howWasExperience,
              textColor: ConstColor.black,
              textSize: 18.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 4.h),
            CustomText(
              title: ConstString.tapToCaptureVibe,
              textColor: ConstColor.grey,
              fontWeight: FontWeight.w500,
              textSize: 14.sp,
              maxLine: 1,
            ),

            SizedBox(height: 14.h),

            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              decoration: BoxDecoration(
                color: ConstColor.black.withAlpha(10),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: ConstColor.silverGray20, width: 1),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    controller.vibes.length,
                    (i) => GestureDetector(
                      onTap: () => controller.onSelectVibe(i),
                      child: Column(
                        children: [
                          Container(
                            width: 56.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.selectedVibe.value == i
                                  ? ConstColor.primaryColor.withAlpha(10)
                                  : ConstColor.white,
                              border: controller.selectedVibe.value == i
                                  ? Border.all(
                                      color: ConstColor.primaryColor,
                                      width: 1.5.w,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                controller.vibeEmojis[i],
                                style: TextStyle(fontSize: 24.sp),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            title: controller.vibes[i],
                            textColor: controller.selectedVibe.value == i
                                ? ConstColor.primaryColor
                                : ConstColor.grey,
                            textSize: 10.sp,
                            fontWeight: controller.selectedVibe.value == i
                                ? FontWeight.w700
                                : FontWeight.w400,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            CustomText(
              title: ConstString.anyStandoutMoments,
              textColor: ConstColor.black,
              textSize: 18.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),

            SizedBox(height: 10.h),

            CustomTextFormField(
              textController: controller.reviewController,
              maxLine: 3,
              backgroundColor: ConstColor.grey.withAlpha(15),
              keyboardType: TextInputType.text,
              hintText: CustomText(
                title:
                    'The music was perfect, or maybe the conversation flowed...',
                textColor: ConstColor.grey,
                textSize: 13.sp,
                maxLine: 3,
              ),
              validator: (_) => null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton(
              onPressed: controller.planAgain,
              isOutLined: true,
              elevation: 0,
              outLineColour: ConstColor.primaryColor,
              height: 50,
              top: 0,
              bottom: 6,
              buttonBorderRadius: 25,
              icon: Icon(
                Icons.refresh_rounded,
                color: ConstColor.primaryColor,
                size: 18.sp,
              ),
              child: CustomText(
                title: ConstString.planAgain,
                textColor: ConstColor.primaryColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            CustomElevatedButton(
              onPressed: controller.submitReview,
              height: 54,
              top: 0,
              buttonBorderRadius: 30,
              gradient: const [
                ConstColor.primaryDeepColor,
                ConstColor.primaryColor,
              ],
              child: CustomText(
                title: ConstString.submit,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeetupHappenedCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _MeetupHappenedCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: isSelected
                ? Border.all(color: ConstColor.primaryColor, width: 1.5.w)
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: isSelected ? ConstColor.primaryColor : ConstColor.grey,
              ),
              SizedBox(height: 6.h),
              CustomText(
                title: label,
                textColor: isSelected
                    ? ConstColor.primaryColor
                    : ConstColor.black,
                textSize: 15.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                maxLine: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
