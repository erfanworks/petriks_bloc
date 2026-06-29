import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import 'Controller/ad_controller.dart';

class SponsoredLocalOfferCard extends StatelessWidget {
  const SponsoredLocalOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdController>();
    return Obx(
          () => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ConstColor.borderColor.withAlpha(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: CustomText(
                  title: c.sponsoredLabel.value,
                  textSize: 11.sp,
                  textColor: ConstColor.grey,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AppImage(
                  path: c.sponsoredImagePath.value,
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerAdCard extends StatelessWidget {
  const BannerAdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdController>();
    return Obx(
          () => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: AppImage(
            path: c.bannerImagePath.value,
            width: double.infinity,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}