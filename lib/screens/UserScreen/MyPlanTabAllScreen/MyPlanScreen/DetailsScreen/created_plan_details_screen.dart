import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../Controller/my_plan_controller.dart';

// ─────────────────────────────────────────
// Shared Plan Info Header (used in both detail screens)
// ─────────────────────────────────────────
class PlanDetailHeader extends StatelessWidget {
  const PlanDetailHeader({super.key, required this.plan, this.statusTag});

  final PlanModel plan;
  final String? statusTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: AppImage(
              path: plan.image,
              width: double.infinity,
              height: 160.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Free/Status
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        title: plan.title,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.black,
                        maxLine: 1,
                      ),
                    ),
                    if (statusTag != null)
                      _StatusTag(label: statusTag!)
                    else
                      _FreeEntryTag(),
                  ],
                ),
                SizedBox(height: 6.h),
                _DetailRow(
                  icon: 'assets/icons/ic_location_pin.svg',
                  label: plan.location,
                ),
                _DetailRow(
                  icon: 'assets/icons/ic_calendar.svg',
                  label: plan.date,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_chill.svg',
                        width: 12.r,
                        height: 12.r,
                        colorFilter: const ColorFilter.mode(
                          ConstColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      CustomText(
                        title: plan.vibe,
                        textSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.primaryColor,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
                _DetailRow(
                  icon: 'assets/icons/language_icon.svg',
                  label: plan.language,
                ),
                _DetailRow(icon: 'assets/icons/person_group_icon.svg', label: plan.type),
                SizedBox(height: 8.h),
                // Avatars + joined + invite
                Row(
                  children: [
                    _StackedAvatars(),
                    SizedBox(width: 8.w),
                    CustomText(
                      title: '${plan.joined}/${plan.total} JOINED',
                      textSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.primaryColor,
                      maxLine: 1,
                    ),
                    const Spacer(),
                    _InviteSmallButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Created Plan Details Screen
class CreatedPlanDetailsScreen extends StatelessWidget {
  const CreatedPlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plan = Get.arguments as PlanModel;
    final c = Get.find<MyPlanController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.planDetails),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AppImage(
                        path: 'assets/images/party_place_img.jpg',
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        top: 145.h,
                        left: 16.w,
                        right: 16.w,
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 12,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    title: ConstString.hangOutPark,
                                    textColor: ConstColor.black,
                                    textSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    maxLine: 1,
                                  ),
                                  _PillBadge(
                                    label: ConstString.freeEntry,
                                    bgColor: const Color(0xFFEDE9FF),
                                    textColor: ConstColor.primaryColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              _DetailRow(
                                icon: "assets/icons/location_icon.svg",
                                label: 'Central Park West, NYC',
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
                                    title: 'Saturday, 24 June',
                                    textColor: ConstColor.grey,
                                    textSize: 12.sp,
                                    maxLine: 1,
                                  ),
                                  SizedBox(width: 10.w),
                                  _PillBadge(
                                    label: '👥 Chill Vibe',
                                    bgColor: const Color(0xFFEDE9FF),
                                    textColor: ConstColor.primaryColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              _DetailRow(
                                icon: "assets/icons/language_icon.svg",
                                label: 'English',
                              ),
                              SizedBox(height: 6.h),
                              _DetailRow(
                                icon: "assets/icons/person_group_icon.svg",
                                label: 'Group Plan',
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  _SmallAvatarStack(),
                                  SizedBox(width: 8.w),
                                  CustomText(
                                    title: '3/6 JOINED',
                                    textColor: ConstColor.primaryColor,
                                    textSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 1,
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _InviteButton(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 180.h),
                  _SectionPad(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(
                          title: '${ConstString.joinedParticipants} (2/6)',
                        ),
                        SizedBox(height: 10.h),
                        ...[
                          {
                            'name': 'Alex Rivera',
                            'img': 'assets/images/onboarding1_img.jpg',
                          },
                          {
                            'name': 'Marcus Chen',
                            'img': 'assets/images/onboarding2_img.jpg',
                          },
                        ].map(
                          (p) =>
                              _ParticipantRow(name: p['name']!, img: p['img']!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),

                  _SectionPad(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(title: ConstString.pollResult),
                        SizedBox(height: 16.h),
                        _PollSection(
                          title: ConstString.timePoll,
                          subtitle: 'Leading choice for Sunday',
                          options: [
                            {'label': 'Sunday 4:00 PM', 'percent': 0.85},
                            {'label': 'Sunday 5:00 PM', 'percent': 0.15},
                          ],
                        ),
                        SizedBox(height: 20.h),
                        _PollSection(
                          title: ConstString.placePoll,
                          subtitle: 'Leading choice for Mohandis Lake',
                          options: [
                            {'label': 'Mohandis Lake', 'percent': 0.85},
                            {'label': 'Dishabille Park', 'percent': 0.15},
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Vote & Lock Settings
                  _SectionPad(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(title: ConstString.voteLockSettings),
                        SizedBox(height: 12.h),
                        Obx(
                          () => _ToggleRow(
                            icon: Icons.lock_outline,
                            label: ConstString.enableAutoLock,
                            value: c.autoLock.value,
                            onChanged: (v) => c.autoLock.value = v,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          title: ConstString.setTime,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          textColor: ConstColor.black,
                          maxLine: 1,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: ConstColor.backgroundColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/clock_icon.svg',
                                width: 16.r,
                                height: 16.r,
                                colorFilter: const ColorFilter.mode(
                                  ConstColor.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: CustomText(
                                  title: 'Today, 11:59 PM',
                                  textSize: 16.sp,
                                  textColor: ConstColor.black,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 1,
                                ),
                              ),
                              Icon(
                                Icons.edit_outlined,
                                size: 19.r,
                                color: ConstColor.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Plan Group Chat preview
                  _SectionPad(
                    child: Row(
                      children: [
                        Container(
                          width: 48.r,
                          height: 48.r,
                          decoration: BoxDecoration(
                            color: ConstColor.primaryColor.withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/message_icon.svg',
                              width: 20.r,
                              height: 20.r,
                              colorFilter: const ColorFilter.mode(
                                ConstColor.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: ConstString.planGroupChat,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                textColor: ConstColor.black,
                                maxLine: 1,
                              ),
                              CustomText(
                                title: 'Marcus: I can bring th...',
                                textSize: 12.sp,
                                textColor: ConstColor.textColor,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        ),
                        CustomElevatedButton(
                          top: 0,
                          width: 100,
                          height: 36,
                          onPressed: () => Get.toNamed('/plan-chat'),
                          color: ConstColor.primaryColor,
                          buttonBorderRadius: 20,
                          child: CustomText(
                            title: ConstString.openChat,
                            textSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            textColor: Colors.white,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 56.h),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
            child: CustomElevatedButton(
              top: 0,
              onPressed: c.goToEditPlan,
              gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.editPlan,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: Colors.white,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable sub-widgets
class _SectionPad extends StatelessWidget {
  const _SectionPad({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => CustomText(
    title: title,
    textSize: 18.sp,
    fontWeight: FontWeight.w600,
    textColor: ConstColor.black,
    maxLine: 1,
  );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, this.trailing});

  final String icon, label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 13.r,
            height: 13.r,
            colorFilter: const ColorFilter.mode(
              ConstColor.primaryDeepColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: CustomText(
              title: label,
              textSize: 12.sp,
              textColor: ConstColor.grey,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _ParticipantRow extends StatelessWidget {
  const _ParticipantRow({required this.name, required this.img});

  final String name, img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        border: Border.all(color: ConstColor.borderColor,width: 1),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        children: [
          ClipOval(
            child: AppImage(
              path: img,
              width: 40.r,
              height: 40.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          CustomText(
            title: name,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _PollSection extends StatelessWidget {
  const _PollSection({
    required this.title,
    required this.subtitle,
    required this.options,
  });

  final String title, subtitle;
  final List<Map<String, dynamic>> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          textSize: 18.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.black,
          maxLine: 1,
        ),
        CustomText(
          title: subtitle,
          textSize: 14.sp,
          textColor: ConstColor.textColor,
          maxLine: 1,
        ),
        SizedBox(height: 10.h),
        ...options.map(
          (o) => _PollBar(
            label: o['label'] as String,
            percent: o['percent'] as double,
          ),
        ),
      ],
    );
  }
}

class _PollBar extends StatelessWidget {
  const _PollBar({required this.label, required this.percent});

  final String label;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: label,
                textSize: 14.sp,
                textColor: ConstColor.black,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
              CustomText(
                title: '${(percent * 100).toInt()}%',
                textSize: 14.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.primaryColor,
                maxLine: 1,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6.h,
              backgroundColor: ConstColor.borderColor,
              valueColor: const AlwaysStoppedAnimation(ConstColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ConstColor.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.r, color: ConstColor.primaryColor),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              title: label,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: ConstColor.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

class _StackedAvatars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 26.h,
      child: Stack(
        children: List.generate(
          2,
          (i) => Positioned(
            left: (i * 16).w,
            child: ClipOval(
              child: AppImage(
                path: 'assets/images/avatar_${i + 1}.png',
                width: 26.r,
                height: 26.r,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FreeEntryTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
    decoration: BoxDecoration(
      color: ConstColor.primaryColor.withAlpha(15),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(
        color: ConstColor.primaryColor.withAlpha(60),
        width: 1,
      ),
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

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
    decoration: BoxDecoration(
      color: const Color(0xFFFFEDD5),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: CustomText(
      title: label,
      textSize: 10.sp,
      fontWeight: FontWeight.w700,
      textColor: const Color(0xFFEA8C00),
      maxLine: 1,
    ),
  );
}

class _InviteSmallButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      color: ConstColor.primaryColor.withAlpha(15),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(
        color: ConstColor.primaryColor.withAlpha(60),
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_invite.svg',
          width: 12.r,
          height: 12.r,
          colorFilter: const ColorFilter.mode(
            ConstColor.primaryColor,
            BlendMode.srcIn,
          ),
        ),
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
  );
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _PillBadge({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ConstColor.primaryDeepColor.withAlpha(40),
          width: 1.5,
        ),
      ),
      child: CustomText(
        title: label,
        textColor: textColor,
        textSize: 12.sp,
        fontWeight: FontWeight.w600,
        maxLine: 1,
      ),
    );
  }
}
class _SmallAvatarStack extends StatelessWidget {
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
class _InviteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
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
    );
  }
}
