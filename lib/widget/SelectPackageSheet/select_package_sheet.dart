import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

class _Package {
  final int number;
  final String label;
  final String price;
  const _Package({required this.number, required this.label, required this.price});
}

class SelectPackageSheet extends StatefulWidget {
  final VoidCallback onConfirm;
  const SelectPackageSheet({super.key, required this.onConfirm});

  @override
  State<SelectPackageSheet> createState() => _SelectPackageSheetState();
}

class _SelectPackageSheetState extends State<SelectPackageSheet> {
  int _selected = 0;

  final _packages = const [
    _Package(number: 1, label: 'Join 1 Plan',   price: 'GBP 0.99'),
    _Package(number: 2, label: 'Join 3 Plans',  price: 'GBP 1.99'),
    _Package(number: 3, label: 'Join 7 Plans',  price: 'GBP 3.99'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: ConstColor.borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.selectPackage,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: ConstString.purchasePackageToJoin,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close, size: 22.sp, color: ConstColor.grey),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Package options
          ...List.generate(_packages.length, (i) {
            final pkg = _packages[i];
            final isSelected = _selected == i;
            return GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: isSelected ? ConstColor.primaryColor.withAlpha(35) : Colors.white, // ← এটা
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: isSelected ? ConstColor.primaryColor : ConstColor.borderColor,
                    width: isSelected ? 1.8 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Number circle
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? ConstColor.primaryColor : const Color(0xFFF0EDFF),
                      ),
                      child: Center(
                        child: CustomText(
                          title: '${pkg.number}',
                          textSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          textColor: isSelected ? Colors.white : ConstColor.grey,
                          maxLine: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: CustomText(
                        title: pkg.label,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textColor: isSelected ? ConstColor.primaryColor : ConstColor.black,
                        maxLine: 1,
                      ),
                    ),
                    CustomText(
                      title: pkg.price,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      textColor: isSelected ? ConstColor.primaryColor : ConstColor.black,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 8.h),

          // Confirm button
          CustomElevatedButton(
            onPressed: widget.onConfirm,
            height: 52,
            top: 0,
            buttonBorderRadius: 30,
            elevation: 0,
            gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
            child: CustomText(
              title: ConstString.confirmAndPay,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}