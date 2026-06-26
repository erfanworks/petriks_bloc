import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/free_trial_ended_controller.dart';

class FreeTrialEndedScreen extends StatelessWidget {
  const FreeTrialEndedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(FreeTrialEndedController());
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LockIcon(),
              SizedBox(height: 20.h),
              Center(
                child: CustomText(
                  title: ConstString.freeTrialEnded,
                  textSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 13.sp, color: ConstColor.grey),
                    children: [
                      TextSpan(text: ConstString.upgradeToPrefix),
                      TextSpan(
                        text: ConstString.appPlusName,
                        style: TextStyle(
                          color: ConstColor.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: ConstString.upgradeToSuffix),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _AlertBox(),
              SizedBox(height: 24.h),
              CustomText(
                title: ConstString.includedWith,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              SizedBox(height: 12.h),
              ...c.features.map((f) => _FeatureRow(label: f)),
              SizedBox(height: 20.h),
              CustomText(
                title: ConstString.chooseYourTier,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              SizedBox(height: 12.h),
              ...List.generate(
                c.plans.length,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Obx(
                    () => _PlanCard(
                      plan: c.plans[i],
                      isSelected: c.selectedPlan.value == i,
                      onTap: () => c.selectPlan(i),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => CustomElevatedButton(
                  onPressed: c.canConfirm ? c.onConfirm : null,
                  height: 48,
                  top: 0,
                  buttonBorderRadius: 30,
                  color: c.canConfirm ? ConstColor.primaryDeepColor : ConstColor.primaryColor.withAlpha(60),
                  elevation: 0,
                  child: CustomText(
                    title: ConstString.confirm,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.white,
                    maxLine: 1,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: GestureDetector(
                  onTap: c.onMaybeLater,
                  child: CustomText(
                    title: ConstString.maybeLater,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Lock Icon ──
class _LockIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.r,
        height: 80.r,
        decoration: BoxDecoration(
          color: ConstColor.primaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Icon(
          Icons.lock_rounded,
          size: 40.sp,
          color: const Color(0xFFFF9800),
        ),
      ),
    );
  }
}

// ── Alert Box ──
class _AlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.redDeep),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: ConstColor.redDeep,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: ConstString.freeTrialExpired,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.redDeep,
                      maxLine: 1,
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      title: ConstString.trialCompleted,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      textColor: const Color(0xFFFF9800),
                      maxLine: 1,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: ConstString.planCreationLocked,
                  textSize: 12.sp,
                  textColor: ConstColor.grey,
                  maxLine: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feature Row ──
class _FeatureRow extends StatelessWidget {
  final String label;

  const _FeatureRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 16.sp,
            color: ConstColor.primaryColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              title: label,
              textSize: 13.sp,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Plan Card ──
class _PlanCard extends StatelessWidget {
  final TrialPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? ConstColor.primaryColor.withAlpha(20) :ConstColor.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? ConstColor.primaryColor
                : ConstColor.borderColor,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ConstColor.primaryColor : ConstColor.grey,
                  width: isSelected ? 5 : 1.5,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: plan.title,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: isSelected
                        ? ConstColor.primaryColor
                        : ConstColor.black,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: plan.subtitle,
                    textSize: 11.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  title: plan.price,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.primaryColor,
                  maxLine: 1,
                ),
                if (plan.period.isNotEmpty)
                  CustomText(
                    title: plan.period,
                    textSize: 11.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
