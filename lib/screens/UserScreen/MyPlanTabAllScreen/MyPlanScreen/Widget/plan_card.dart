import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../Controller/my_plan_controller.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    required this.onTap,
    this.isJoined = false,
  });

  final PlanModel plan;
  final VoidCallback onTap;
  final bool isJoined;

  @override
  Widget build(BuildContext context) {
    final bool isPrivate = true;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: AppImage(
                    path: plan.image,
                    width: double.infinity,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  left: 10.w,
                  child: _Badge(
                    label: plan.type,
                    icon: 'assets/icons/person_group_icon.svg',
                    bgColor: const Color(0xFF6C5CE7),
                    textColor: Colors.white,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: isPrivate
                          ? Colors.white.withAlpha(200)
                          : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        if (isPrivate)
                          Icon(
                            Icons.lock_outline,
                            size: 12.sp,
                            color: ConstColor.primaryColor,
                          )
                        else
                          Icon(
                            Icons.public,
                            size: 12.sp,
                            color: const Color(0xFF2E7D32),
                          ),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: isPrivate ? "Private" : "Public",
                          textColor: isPrivate
                              ? ConstColor.primaryColor
                              : const Color(0xFF2E7D32),
                          textSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  left: 10.w,
                  child: _Badge(
                    label: 'Quite',
                    bgColor: const Color(0xFFF0C4AA),
                    textColor: const Color(0xFF763302),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: plan.title,
                          textSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.black,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ),
                      _FreeTag(),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _MetaRow(icon: Icons.language_rounded, label: plan.language),
                  _MetaRow(
                    icon: Icons.location_on_outlined,
                    label: plan.location,
                  ),
                  _MetaRow(
                    icon: Icons.people_outline_rounded,
                    label: 'Male (20-25)',
                  ),

                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 13.sp,
                        color: ConstColor.primaryDeepColor,
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        title: plan.date,
                        textColor: ConstColor.textColor,
                        textSize: 11.sp,
                        maxLine: 1,
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        width: 1,
                        height: 12.h,
                        color: ConstColor.borderColor,
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.access_time,
                        size: 13.sp,
                        color: ConstColor.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: 'Vote Now',
                        textColor: ConstColor.primaryColor,
                        textSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                      const Spacer(),
                      _InviteButton(),
                    ],
                  ),

                  SizedBox(height: 12.h),
                  Divider(height: 1, color: ConstColor.borderColor),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      if (isJoined) ...[_HostSection(), const Spacer()],
                      _MemberStackSection(),
                      if (!isJoined && plan.tag == 'COMPLETED') ...[
                        const Spacer(),
                        _FeedbackAction(
                          onTap: () {
                            // Get.toNamed(AppRoutes.feedbackScreen);
                          },
                        ),
                      ],
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

class _FeedbackAction extends StatelessWidget {
  final VoidCallback onTap;

  const _FeedbackAction({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2E7D32).withAlpha(50),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 18.sp,
              color: const Color(0xFF2E7D32),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  title: "COMPLETED",
                  textSize: 8.sp,
                  fontWeight: FontWeight.w800,
                  textColor: const Color(0xFF2E7D32).withAlpha(180),
                ),
                CustomText(
                  title: "Give Feedback",
                  textSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xFF2E7D32),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.sp,
              color: const Color(0xFF2E7D32),
            ),
          ],
        ),
      ),
    );
  }
}

class _HostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleAvatar(path: 'assets/images/person1_img.jpg'),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: "Marvin McKinney",
              textSize: 12.sp,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),
            CustomText(
              title: "Host",
              textSize: 10.sp,
              textColor: Colors.grey.shade600,
            ),
          ],
        ),
      ],
    );
  }
}

class _MemberStackSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 65.w,
          height: 28.h,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: _CircleAvatar(path: 'assets/images/person1_img.jpg'),
              ),
              Positioned(
                left: 18.w,
                child: _CircleAvatar(path: 'assets/images/onboarding3_img.jpg'),
              ),
              Positioned(
                left: 36.w,
                child: Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5.w),
                  ),
                  child: Center(
                    child: CustomText(
                      title: '+1',
                      textColor: Colors.white,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        CustomText(
          title: '11 JOINED',
          textColor: const Color(0xFF6C5CE7),
          textSize: 10.sp,
          fontWeight: FontWeight.w800,
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.icon,
  });

  final String label;
  final Color bgColor, textColor;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon!,
              width: 12.r,
              height: 12.r,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
            SizedBox(width: 4.w),
          ],
          CustomText(
            title: label,
            textSize: 10.sp,
            fontWeight: FontWeight.w700,
            textColor: textColor,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _FreeTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FF),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ConstColor.primaryColor.withAlpha(40),
          width: 1,
        ),
      ),
      child: CustomText(
        title: ConstString.freeEntry,
        textSize: 10.sp,
        fontWeight: FontWeight.w600,
        textColor: ConstColor.primaryColor,
        maxLine: 1,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: ConstColor.primaryDeepColor),
          SizedBox(width: 8.w),
          Flexible(
            child: CustomText(
              title: label,
              textSize: 12.sp,
              textColor: ConstColor.textColor,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _InviteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.inviteFriendsListScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE9FF), // Very light purple
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ConstColor.borderColor, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_add_alt_1_outlined,
              size: 14.sp,
              color: ConstColor.primaryColor,
            ),
            SizedBox(width: 4.w),
            CustomText(
              title: "INVITE",
              textSize: 10.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.primaryColor,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

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
