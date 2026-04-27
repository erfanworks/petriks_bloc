import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
    this.showJoinedCount = false,
  });

  final PlanModel plan;
  final VoidCallback onTap;
  final bool showJoinedCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cover image ──
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16.r)),
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
                    bgColor: ConstColor.primaryColor.withAlpha(200),
                    textColor: Colors.white,
                  ),
                ),
                if (plan.tag != null)
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: _Badge(
                      label: plan.tag!,
                      bgColor: plan.tag == 'COMPLETED'
                          ? const Color(0xFFFFEDD5)
                          : const Color(0xFFD4F5E2),
                      textColor: plan.tag == 'COMPLETED'
                          ? const Color(0xFFEA8C00)
                          : const Color(0xFF1A8A4A),
                    ),
                  ),
                // Bookmark (completed)
                if (plan.tag == 'COMPLETED')
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.bookmark_border_rounded,
                          size: 16.r, color: ConstColor.iconColor),
                    ),
                  ),
                // New-Comer label bottom-left
                Positioned(
                  bottom: 8.h,
                  left: 10.w,
                  child: _Badge(
                    label: ConstString.newComerFriendly,
                    bgColor: const Color(0xFFF0C4AA),
                    textColor: const Color(0xFF763302),
                  ),
                ),
              ],
            ),

            // ── Info ──
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Free Entry
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          title: plan.title,
                          textSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          textColor: ConstColor.black,
                          maxLine: 1,
                        ),
                      ),
                      _FreeTag(),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // Vibe chip
                  _VibeChip(vibe: plan.vibe),
                  SizedBox(height: 6.h),

                  // Meta rows
                  _MetaRow(icon: 'assets/icons/language_icon.svg', label: plan.language),
                  _MetaRow(icon: 'assets/icons/location_icon.svg', label: plan.location),

                  // Date + Time row
                  Row(
                    children: [
                      _MetaRow(
                          icon: 'assets/icons/calender_icon.svg',
                          label: plan.date),
                      SizedBox(width: 16.w,),
                      _MetaRow(
                          icon: 'assets/icons/clock_icon.svg',
                          label: plan.time),
                    ],
                  ),

                  if (showJoinedCount)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: _MetaRow(
                        icon: 'assets/icons/ic_group.svg',
                        label: '${plan.joined}/${plan.total} joined',
                      ),
                    ),

                  // Invite button
                  Align(
                    alignment: Alignment.centerRight,
                    child: _InviteButton(),
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

// ── Reusable small widgets ──

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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(icon!,
                width: 12.r,
                height: 12.r,
                colorFilter:
                ColorFilter.mode(textColor, BlendMode.srcIn)),
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
            color: ConstColor.primaryColor.withAlpha(60), width: 1),
      ),
      child: CustomText(
        title: ConstString.freeEntry,
        textSize: 10.sp,
        fontWeight: FontWeight.w600,
        textColor: ConstColor.primaryColor,
        maxLine: 1,
      ),
    );
  }
}

class _VibeChip extends StatelessWidget {
  const _VibeChip({required this.vibe});
  final String vibe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD4F5E2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(title: "🌿"),
          SizedBox(width: 3.w),
          CustomText(
            title: vibe,
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: const Color(0xFF1A8A4A),
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});
  final String icon, label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon,
              width: 12.r,
              height: 12.r,
              colorFilter: const ColorFilter.mode(
                  ConstColor.primaryDeepColor, BlendMode.srcIn)),
          SizedBox(width: 6.w),
          Flexible(
            child: CustomText(
              title: label,
              textSize: 11.sp,
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
      onTap: (){Get.toNamed(AppRoutes.inviteFriendsListScreen);},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: ConstColor.primaryColor.withAlpha(15),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: ConstColor.primaryColor.withAlpha(60), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/invite_icon.svg',
                width: 12.r,
                height: 12.r,
                colorFilter: const ColorFilter.mode(
                    ConstColor.primaryColor, BlendMode.srcIn)),
            SizedBox(width: 4.w),
            CustomText(
              title: ConstString.invite,
              textSize: 11.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.primaryColor,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}