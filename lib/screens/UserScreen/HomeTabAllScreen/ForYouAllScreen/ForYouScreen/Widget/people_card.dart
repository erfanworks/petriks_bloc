import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/for_you_controller.dart';

class PeopleCard extends StatelessWidget {
  final PersonItem item;

  const PeopleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForYouController>();

    return InkWell(
      onTap: () => controller.onSayHello(item),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: AppImage(
                path: item.image,
                width: double.infinity,
                height: 230.h,
                fit: BoxFit.cover,
              ),
            ),

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
                      Colors.black.withAlpha(250),
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
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: item.bio,
                      textColor: Colors.white.withAlpha(200),
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 13.sp, color: Colors.white),
                        SizedBox(width: 2.w),
                        CustomText(
                          title: item.distance,
                          textColor: Colors.white,
                          textSize: 12.sp,
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
                        title: ConstString.sayAWarn,
                        textColor: Colors.white,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}