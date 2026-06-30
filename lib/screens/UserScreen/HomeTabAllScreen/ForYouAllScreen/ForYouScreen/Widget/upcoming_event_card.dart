import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/for_you_controller.dart';

class UpcomingEventCard extends StatelessWidget {
  final EventItem item;

  const UpcomingEventCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForYouController>();

    return InkWell(
      onTap: () => controller.onEventTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 10.r,
              spreadRadius: 1.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                    height: 230.h,
                    fit: BoxFit.cover,
                  ),
                ),

                // SPONSORED badge (left top)
                if (item.isOpen)
                  Positioned(
                    top: 8.h,
                    left: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB35A00),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            color: ConstColor.white,
                            size: 13.sp,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            title: ConstString.sponsored,
                            textColor: Colors.white,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                // Group badge (right top)
                Positioned(
                  top: 8.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          width: 10.w,
                          height: 10.h,
                          "assets/icons/social_icon.svg",
                          colorFilter: ColorFilter.mode(
                            ConstColor.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          title: ConstString.group,
                          textColor: ConstColor.white,
                          textSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF0C4AA),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: ConstString.quite,
                      textColor: Color(0xFF763302),
                      textSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ),

                // Bookmark icon
                // Positioned(
                //   top: 12.h,
                //   right: 12.w,
                //   child: Container(
                //     width: 36.w,
                //     height: 36.w,
                //     decoration: BoxDecoration(
                //       color: ConstColor.silverGray20,
                //       shape: BoxShape.circle,
                //       border: Border.all(color: ConstColor.grey, width: 1),
                //     ),
                //     child: Center(
                //       child: SvgPicture.asset(
                //         "assets/icons/book_mark_icon.svg",
                //         width: 12.w,
                //         height: 15.h,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            // ─── Details Section ───
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          title: item.title,
                          textColor: const Color(0xFF1A1A2E),
                          textSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ),
                      if (item.isFreeEntry)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          margin: EdgeInsets.only(left: 8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FF),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: CustomText(
                            title: ConstString.freeEntry,
                            textColor: ConstColor.primaryColor,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Language
                  _InfoRow(icon: Icons.language_outlined, label: item.language),
                  SizedBox(height: 4.h),

                  // Location
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: item.location,
                  ),
                  SizedBox(height: 4.h),

                  // Gender
                  _InfoRow(icon: Icons.people_outline, label: item.gender),
                  // SizedBox(height: 12.h),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 13.sp,
                        color: ConstColor.primaryDeepColor,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: CustomText(
                          title: item.date,
                          textColor: ConstColor.textColor,
                          fontWeight: FontWeight.w500,
                          textSize: 12.sp,
                          maxLine: 1,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 1,
                        height: 12.h,
                        color: ConstColor.iconColor,
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.access_time,
                        size: 13.sp,
                        color: ConstColor.primaryDeepColor,
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: CustomText(
                          title: ConstString.voteNow,
                          textColor: ConstColor.primaryColor,
                          textSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                      ),
                      Spacer(),
                      // Invite button
                      GestureDetector(
                        onTap: () => controller.onInviteTap(item),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: ConstColor.borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_add_alt_1_outlined,
                                size: 13.sp,
                                color: ConstColor.primaryColor,
                              ),
                              SizedBox(width: 2.w),
                              CustomText(
                                title: ConstString.invite,
                                textColor: ConstColor.primaryColor,
                                textSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),
                  Divider(height: 1, color: ConstColor.borderColor),
                  SizedBox(height: 10.h),

                  // Host + Joined row
                  Row(
                    children: [
                      // Host avatar
                      ClipOval(
                        child: AppImage(
                          path: "assets/images/onboarding5_img.jpg",
                          width: 36.r,
                          height: 36.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: item.hostName,
                            textColor: ConstColor.black,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                          ),
                          CustomText(
                            title: ConstString.host,
                            textColor: ConstColor.primaryColor,
                            textSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ],
                      ),
                      const Spacer(),
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
                      // // Stacked member avatars
                      // SizedBox(
                      //   width: 58.w,
                      //   height: 26.h,
                      //   child: Stack(
                      //     children:
                      //         List.generate(
                      //           item.memberImages.length > 2
                      //               ? 2
                      //               : item.memberImages.length,
                      //           (i) => Positioned(
                      //             left: (i * 16).w,
                      //             child: ClipOval(
                      //               child: AppImage(
                      //                 path: item.memberImages[i],
                      //                 width: 26.r,
                      //                 height: 26.r,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //             ),
                      //           ),
                      //         )..add(
                      //           Positioned(
                      //             left: 32.w,
                      //             child: Container(
                      //               width: 26.r,
                      //               height: 26.r,
                      //               decoration: const BoxDecoration(
                      //                 color: ConstColor.primaryColor,
                      //                 shape: BoxShape.circle,
                      //               ),
                      //               child: Center(
                      //                 child: CustomText(
                      //                   title: '+${item.extraCount}',
                      //                   textSize: 8.sp,
                      //                   fontWeight: FontWeight.w700,
                      //                   textColor: Colors.white,
                      //                   maxLine: 1,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //   ),
                      // ),
                      //
                      // SizedBox(width: 6.w),
                      // CustomText(
                      //   title: item.joined,
                      //   textColor: ConstColor.primaryColor,
                      //   textSize: 12.sp,
                      //   fontWeight: FontWeight.w700,
                      //   maxLine: 1,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: ConstColor.primaryDeepColor),
        SizedBox(width: 6.w),
        Expanded(
          child: CustomText(
            title: label,
            textColor: ConstColor.textColor,
            textSize: 13.sp,
            maxLine: 1,
            fontWeight: FontWeight.w500,
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