import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/subscription_controller.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SubscriptionController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.subscription, showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            _TabBar(c: c),
            SizedBox(height: 16.h),
            Obx(
              () => c.selectedTab.value == 0
                  ? _PlanCard(c: c, isPremium: false)
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: 16.h),
            _PlanCard(c: c, isPremium: true),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

// ─── Tab Bar ──────────────────────────────────────────────────────────────────
class _TabBar extends StatelessWidget {
  final SubscriptionController c;

  const _TabBar({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: ConstColor.boxColor,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            _Tab(
              label: ConstString.monthly,
              isSelected: c.selectedTab.value == 0,
              onTap: () => c.onTabChanged(0),
            ),
            _Tab(
              label: ConstString.yearly,
              isSelected: c.selectedTab.value == 1,
              onTap: () => c.onTabChanged(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.white : Colors.transparent,
            borderRadius: BorderRadius.circular(26.r),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)]
                : [],
          ),
          child: Center(
            child: CustomText(
              title: label,
              textSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              textColor: isSelected ? ConstColor.primaryColor : ConstColor.grey,
              maxLine: 1,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Plan Card ────────────────────────────────────────────────────────────────
class _PlanCard extends StatelessWidget {
  final SubscriptionController c;
  final bool isPremium;

  const _PlanCard({required this.c, required this.isPremium});

  @override
  Widget build(BuildContext context) {
    final features = isPremium ? c.premiumFeatures : c.freeFeatures;
    return Container(
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isPremium
            ? Border.all(color: ConstColor.primaryColor, width: 1.5)
            : Border.all(color: ConstColor.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isPremium)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ConstColor.primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomText(
                        title: ConstString.recommended,
                        textSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.primaryColor,
                        maxLine: 1,
                      ),
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: isPremium
                                ? ConstString.premium
                                : ConstString.free,
                            textSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            textColor: isPremium
                                ? ConstColor.primaryColor
                                : ConstColor.black,
                            maxLine: 1,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            title: isPremium
                                ? "ConstString.premiumFullDesc "
                                : ConstString.freeDesc,
                            textSize: 12.sp,
                            textColor: ConstColor.grey,
                            maxLine: 2,
                          ),
                        ],
                      ),
                    ),
                    if (isPremium)
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              title: c.priceLabel,
                              textSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              textColor: ConstColor.black,
                              maxLine: 1,
                            ),
                            CustomText(
                              title: c.periodLabel,
                              textSize: 12.sp,
                              textColor: ConstColor.grey,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      )
                    else
                      CustomText(
                        title: ConstString.free,
                        textSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.black,
                        maxLine: 1,
                      ),
                  ],
                ),
                SizedBox(height: 14.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: features
                  .map((f) => _FeatureRow(label: f.label))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
            child: CustomElevatedButton(
              onPressed: isPremium ? c.onUpgradePremium : c.onJoinFree,
              height: 48,
              top: 0,
              buttonBorderRadius: 30,
              isOutLined: !isPremium,
              elevation: 0,
              outLineColour: ConstColor.primaryColor,
              child: CustomText(
                title: isPremium
                    ? ConstString.upgradeToPremium
                    : ConstString.joinFree,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: isPremium
                    ? ConstColor.white
                    : ConstColor.primaryColor,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String label;

  const _FeatureRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
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
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}
