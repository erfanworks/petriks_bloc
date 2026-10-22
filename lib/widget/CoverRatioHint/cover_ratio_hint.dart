import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class CoverRatioHint extends StatelessWidget {
  final String ratio;
  final String size;

  const CoverRatioHint({super.key, required this.ratio, required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Icon(Icons.info_outline_rounded,
                size: 13.r, color: ConstColor.grey),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: CustomText(
              title: 'Recommended ratio $ratio ($size)',
              textSize: 11.sp,
              textColor: ConstColor.grey,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}
