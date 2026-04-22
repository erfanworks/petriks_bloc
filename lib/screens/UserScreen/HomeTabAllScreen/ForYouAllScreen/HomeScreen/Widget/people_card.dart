import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/home_controller.dart';

class PeopleCard extends StatelessWidget {
  final PersonItem item;

  const PeopleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // ---- Person Image ----
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AppImage(
              path: item.image,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),

          // ---- Bottom gradient overlay ----
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(200),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.name,
                    textColor: Colors.white,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: item.bio,
                    textColor: Colors.white.withAlpha(200),
                    textSize: 11.sp,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 11.sp, color: Colors.white.withAlpha(180)),
                      SizedBox(width: 2.w),
                      CustomText(
                        title: item.distance,
                        textColor: Colors.white.withAlpha(180),
                        textSize: 10.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomElevatedButton(
                    onPressed: () => controller.onSayHello(item),
                    color: ConstColor.primaryColor,
                    height: 36,
                    top: 0,
                    buttonBorderRadius: 20,
                    child: CustomText(
                      title: 'Say a warm Hello',
                      textColor: Colors.white,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}