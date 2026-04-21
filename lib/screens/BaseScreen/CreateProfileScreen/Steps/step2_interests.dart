import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../widget/text/custom_text.dart';
import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';

class Step2Interests extends StatelessWidget {
  const Step2Interests({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.yourInterests,
      subtitle: ConstString.pickAFewWell,
      child: Obx(() => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
        children: c.interests.map((item) {
          final label = item['label']!;
          final icon = item['icon']!;
          final selected = c.selectedInterests.contains(label);

          return GestureDetector(
            onTap: () => c.toggleInterest(label),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF6C5CE7).withAlpha(20)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF6C5CE7)
                      : const Color(0xFFE0DFF0),
                  width: selected ? 1.8 : 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon circle
                  Container(
                    width: 54.r,
                    height: 54.r,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF6C5CE7).withAlpha(20)
                          : const Color(0xFFF0EEF9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        width: 25.r,
                        height: 25.r,
                        colorFilter: ColorFilter.mode(
                          selected
                              ? const Color(0xFF6C5CE7)
                              : const Color(0xFF6B6B80),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    title: label,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.textColor,
                    textAlign: TextAlign.center,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}