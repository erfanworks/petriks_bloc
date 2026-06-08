import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/my_plan_controller.dart';
import 'Widget/plan_card.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyPlanController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.myPlan, showBack: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Obx(() => Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: ConstColor.boxColor,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  _TabButton(
                    label: ConstString.created,
                    selected: c.selectedTab.value == 0,
                    onTap: () => c.switchTab(0),
                  ),
                  _TabButton(
                    label: ConstString.joined,
                    selected: c.selectedTab.value == 1,
                    onTap: () => c.switchTab(1),
                  ),
                ],
              ),
            )),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: c.selectedTab.value == 0
                  ? c.createdPlans.length
                  : c.joinedPlans.length,
              itemBuilder: (_, i) {
                final plan = c.selectedTab.value == 0
                    ? c.createdPlans[i]
                    : c.joinedPlans[i];
                return PlanCard(
                  plan: plan,
                  isJoined: c.selectedTab.value == 1,
                  onTap: () => c.selectedTab.value == 0
                      ? c.goToCreatedDetails(plan)
                      : c.goToJoinedDetails(plan),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
            color: selected ? ConstColor.primaryColor : ConstColor.black.withAlpha(20),
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: Center(
            child: CustomText(
              title: label,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
              textColor: selected ? Colors.white : ConstColor.grey,
              maxLine: 1,
            ),
          ),
        ),
      ),
    );
  }
}