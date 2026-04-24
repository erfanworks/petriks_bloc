import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';

class LogisticsCard extends StatelessWidget {
  const LogisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _LogisticsRow(label: 'Date', value: 'Oct 22, 2023'),
          _Divider(),
          _LogisticsRow(label: 'Time', value: '17:00 (Local)'),
          _Divider(),
          _LogisticsRow(label: 'Location', value: 'Sector 4, UK'),
          _Divider(),
          _LogisticsRow(label: 'Activity', value: 'Football'),
        ],
      ),
    );
  }
}
class _LogisticsRow extends StatelessWidget {
  final String label;
  final String value;

  const _LogisticsRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title: label, textColor: ConstColor.grey, textSize: 14.sp, maxLine: 1),
          CustomText(title: value, textColor: ConstColor.black, textSize: 15.sp, fontWeight: FontWeight.w600, maxLine: 1),
        ],
      ),
    );
  }
}
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1.h, color: const Color(0xFFEEEEEE));
  }
}
