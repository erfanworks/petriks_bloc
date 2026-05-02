import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';

class FeaturedEventCard extends StatelessWidget {
  const FeaturedEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.planDetailsScreen);
          },
          child: Container(
            height: 190.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFD7CAFF), Color(0x1A9152A3), Color(0xFFD7CAFF)],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---- Left: Floating Image Box ----
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: AppImage(
                          path: 'assets/images/party_img.png',
                          width: 160.w,
                          height: 160.h,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        bottom: 15.h,
                        left: 50.w,
                        right: 6.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0C4AA),
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: CustomText(
                            title: ConstString.newComerFriendly,
                            textColor: const Color(0xFF763302),
                            textSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                // ---- Right: Event Info ----
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      top: 16.h,
                      bottom: 14.h,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---- Title ----
                        CustomText(
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          title: ConstString.nightOutFriendly,
                          textColor: ConstColor.black,
                          textSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
          
                        SizedBox(height: 8.h),
          
                        // ---- Info Rows ----
                        _InfoRow(icon: Icons.language_rounded, label: 'English'),
                        SizedBox(height: 5.h),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Central Park West',
                        ),
                        SizedBox(height: 5.h),
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Saturday, 24 June',
                        ),
                        SizedBox(height: 5.h),
                        _InfoRow(
                          icon: Icons.access_time_rounded,
                          label: '6:30 PM Today',
                        ),
          
                        const Spacer(),
          
                        // ---- Avatars + Joined ----
                        Row(
                          children: [
                            _AvatarStack(),
                            SizedBox(width: 8.w),
                            CustomText(
                              title: '3/6 JOINED',
                              textColor: ConstColor.primaryColor,
                              textSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: -12.h,
          right: 5.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ConstColor.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: CustomText(
              title: 'POPULAR',
              textColor: Colors.white,
              textSize: 10.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ),
        ),
      ],
    );
  }
}

// ---- Info Row ----
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13.sp, color: ConstColor.primaryDeepColor),
        SizedBox(width: 6.w),
        Flexible(
          child: CustomText(
            title: label,
            textColor: ConstColor.textColor,
            textSize: 12.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ),
      ],
    );
  }
}

// ---- Avatar Stack ----
class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.w,
      height: 26.h,
      child: Stack(
        children: [
          // Avatar 1
          Positioned(
            left: 0,
            child: _CircleAvatar(path: 'assets/images/onboarding5_img.jpg'),
          ),
          // Avatar 2
          Positioned(
            left: 15.w,
            child: _CircleAvatar(path: 'assets/images/onboarding3_img.jpg'),
          ),
          // +1 count badge
          Positioned(
            left: 30.w,
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ConstColor.primaryColor,
                border: Border.all(color: Colors.white, width: 1.5.w),
              ),
              child: Center(
                child: CustomText(
                  title: '+1',
                  textColor: Colors.white,
                  textSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Single Circle Avatar ----
class _CircleAvatar extends StatelessWidget {
  final String path;

  const _CircleAvatar({required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5.w),
      ),
      child: ClipOval(
        child: AppImage(
          path: path,
          width: 26.w,
          height: 26.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
