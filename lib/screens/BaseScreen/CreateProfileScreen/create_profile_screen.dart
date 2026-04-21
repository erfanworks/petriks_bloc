import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Controller/create_profile_controller.dart';
import 'Steps/step1_basic_info.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  static const _steps = [
    Step1BasicInfo(),
    // Step2Interests(),
    // Step3Languages(),
    // Step4MeetPref(),
    // Step5Vibe(),
    // Step6Availability(),
    // Step7Mood(),
    // Step8Travel(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          children: [
            // ── Step progress bar ──
            _StepProgressBar(controller: controller),

            // ── Step content ──
            Expanded(
              child: Obx(() => _steps[controller.currentStep.value]),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable step progress indicator ──
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
                          ? const Color(0xFF6C5CE7)
                          : const Color(0xFFDDD8F5),
                      borderRadius: BorderRadius.circular(2.r),
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
