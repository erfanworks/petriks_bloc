import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';

import 'Controller/create_profile_controller.dart';
import 'Steps/step1_basic_info.dart';
import 'Steps/step2_interests.dart';
import 'Steps/step3_languages.dart';
import 'Steps/step4_meet_pref.dart';
import 'Steps/step5_step6.dart';
import 'Steps/step7_step8.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  static const _steps = [
    Step1BasicInfo(),
    Step2Interests(),
    Step3Languages(),
    Step4MeetPref(),
    Step5Vibe(),
    Step6Availability(),
    Step7Mood(),
    Step8Travel(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(onBack: () {
        if (controller.currentStep.value > 0) {
          controller.currentStep.value--;
        } else {
          Get.back();
        }
      },),
      body: SafeArea(
        child: Column(
          children: [
            _StepProgressBar(controller: controller),

            Expanded(
              child: Obx(() => _steps[controller.currentStep.value]),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepProgressBar extends StatelessWidget {
  const _StepProgressBar({required this.controller});
  final CreateProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Obx(() {
        final step = controller.currentStep.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STEP ${step + 1} OF ${CreateProfileController.totalSteps}',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF6C5CE7),
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: List.generate(
                CreateProfileController.totalSteps,
                    (i) => Expanded(
                  child: Container(
                    height: 4.h,
                    margin: EdgeInsets.only(
                        right: i < CreateProfileController.totalSteps - 1 ? 4.w : 0),
                    decoration: BoxDecoration(
                      color: i <= step
                          ? ConstColor.primaryColor
                          : const Color(0xFFE3E2F6),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
