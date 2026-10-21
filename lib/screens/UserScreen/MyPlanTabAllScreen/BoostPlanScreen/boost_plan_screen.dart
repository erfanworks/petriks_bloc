import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/boost_plan_controller.dart';

class BoostPlanScreen extends StatelessWidget {
  const BoostPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(BoostPlanController());
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.boostYourPlan, showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: ConstColor.primaryColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: ConstString.timeLimit,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.white,
                        maxLine: 1,
                      ),
                      CustomText(
                        title: ConstString.essentialFor,
                        textSize: 12.sp,
                        textColor: ConstColor.white,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
                CustomText(
                  title: ConstString.boostPrice,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.white,
                  maxLine: 1,
                ),
              ],
            ),
          ),
            SizedBox(height: 24.h),
            // ── Feature Card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ConstColor.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.feature,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    title: ConstString.boostFeatureDesc,
                    textSize: 13.sp,
                    textColor: ConstColor.grey,
                    maxLine: 2,
                  ),
                  SizedBox(height: 16.h),
                  ...c.features.map((f) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline_rounded, size: 18.sp, color: ConstColor.primaryColor),
                        SizedBox(width: 10.w),
                        CustomText(title: f, textSize: 14.sp, textColor: ConstColor.black, maxLine: 1),
                      ],
                    ),
                  )),
                ],
              ),
            ),

            // SizedBox(height: 24.h),
            //
            // CustomText(
            //   title: ConstString.selectAPackage,
            //   textSize: 17.sp,
            //   fontWeight: FontWeight.w700,
            //   textColor: ConstColor.black,
            //   maxLine: 1,
            // ),
            // SizedBox(height: 12.h),
            //
            // // ── Packages ──
            // ...List.generate(c.packages.length, (i) => Padding(
            //   padding: EdgeInsets.only(bottom: 12.h),
            //   child: Obx(() => _PackageTile(
            //     pkg: c.packages[i],
            //     isSelected: c.selectedPackage.value == i,
            //     onTap: () => c.selectPackage(i),
            //   )),
            // )),
            //
            // SizedBox(height: 12.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h + MediaQuery.of(context).padding.bottom),
        child: CustomElevatedButton(
          onPressed: c.onConfirm,
          height: 52,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.confirmAndPay,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: Colors.white,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}

class _PackageTile extends StatelessWidget {
  final BoostPackage pkg;
  final bool isSelected;
  final VoidCallback onTap;
  const _PackageTile({required this.pkg, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: ConstColor.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor : ConstColor.borderColor,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? ConstColor.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? ConstColor.primaryColor : ConstColor.grey,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 13.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: pkg.title,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: pkg.subtitle,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
            CustomText(
              title: pkg.price,
              textSize: 15.sp,
              fontWeight: FontWeight.w700,
              textColor: isSelected ? ConstColor.primaryColor : ConstColor.black,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}