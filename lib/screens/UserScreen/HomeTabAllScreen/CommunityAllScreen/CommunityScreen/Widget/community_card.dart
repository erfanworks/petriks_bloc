// ---- Community Card ----
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/community_controller.dart';

class CommunityCard extends StatelessWidget {
  final CommunityItem item;
  final VoidCallback onTap;

  const CommunityCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Image ----
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: AppImage(
                  path: item.image,
                  width: double.infinity,
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: ConstColor.boxColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    title: item.tag,
                    textColor: ConstColor.primaryColor,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: item.title,
                      textColor: ConstColor.black,
                      textSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                    Row(
                      children: [
                        Icon(Icons.people_outline, size: 14.sp, color: ConstColor.textColor),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: item.memberCount,
                          textColor: ConstColor.textColor,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                CustomText(
                  title: item.description,
                  textColor: ConstColor.textColor,
                  textSize: 14.sp,
                  maxLine: 3,
                ),
                SizedBox(height: 12.h),
                CustomElevatedButton(
                  onPressed: onTap,
                  height: 44,
                  top: 0,
                  buttonBorderRadius: 22,
                  gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryDeepColor],
                  child: CustomText(
                    title: ConstString.viewCommunity,
                    textColor: Colors.white,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}