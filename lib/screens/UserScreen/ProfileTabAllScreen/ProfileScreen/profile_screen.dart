import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    return Scaffold(
      appBar: GlobalAppBar(
        title: ConstString.profile,
        showBack: false,
        actions: [
          GestureDetector(
            onTap: c.onSettingsTap,
            child: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(
                Icons.settings_outlined,
                size: 22.sp,
                color: ConstColor.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _TopCard(c: c),
            SizedBox(height: 8.h),
            _AboutSection(c: c),
            SizedBox(height: 8.h),
            _InterestSection(c: c),
            SizedBox(height: 8.h),
            _BadgesSection(c: c),
            SizedBox(height: 8.h),
            _WeeklyAvailabilitySection(c: c),
            SizedBox(height: 8.h),
            _CurrentMoodSection(c: c),
            SizedBox(height: 8.h),
            _IndicatorsSection(c: c),
            SizedBox(height: 8.h),
            _CommunitySection(c: c),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _TopCard extends StatelessWidget {
  final ProfileController c;

  const _TopCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.white,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36.r),
                    child: AppImage(
                      path: 'assets/images/onboarding2_img.jpg',
                      width: 72.w,
                      height: 72.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        color: ConstColor.primaryColor,
                        border: Border.all(color: ConstColor.white, width: 1.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 13.r,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => CustomText(
                        title: c.userName.value,
                        textSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        textColor: ConstColor.black,
                        maxLine: 1,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: ConstColor.grey,
                          ),
                          SizedBox(width: 2.w),
                          Flexible(
                            child: CustomText(
                              title:
                                  '${c.userLocation.value}  ·  ${c.userLanguages.value}',
                              textSize: 14.sp,
                              textColor: ConstColor.textColor,
                              fontWeight: FontWeight.w500,
                              maxLine: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Got Verified button
              GestureDetector(
                onTap: () {Get.toNamed(AppRoutes.subscriptionScreen);},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: ConstColor.primaryColor),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    title: ConstString.gotVerified,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.primaryColor,
                    maxLine: 1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Obx(
            () => CustomText(
              title: c.userBio.value,
              textSize: 14.sp,
              textColor: ConstColor.grey,
              fontWeight: FontWeight.w500,
              maxLine: 5,
            ),
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: c.onFollowersTap,
                  child: _StatText(
                    count: c.followerCount.value,
                    label: ConstString.followers,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Obx(
                () => GestureDetector(
                  onTap: c.onFollowingTap,
                  child: _StatText(
                    count: c.followingCount.value,
                    label: ConstString.following,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _PremiumBanner(c: c),
          SizedBox(height: 22.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(ConstString.introVideoProfile),
              CustomText(title: ConstString.tapAndHoldToReplace,)
            ],
          ),
          SizedBox(height: 14.h),
          _IntroVideoCard(c: c),
        ],
      ),
    );
  }
}

class _StatText extends StatelessWidget {
  final int count;
  final String label;

  const _StatText({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$count ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ConstColor.primaryColor,
              fontFamily: 'Roboto',
            ),
          ),
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              color: ConstColor.primaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumBanner extends StatelessWidget {
  final ProfileController c;

  const _PremiumBanner({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Color(0xFFF97316),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: ConstString.yourPlan,
                textSize: 12.sp,
                textColor: ConstColor.white.withAlpha(200),
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  CustomText(
                    title: ConstString.free,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.white,
                    maxLine: 1,
                  ),
                  SizedBox(width: 4.w),
                  Text('⭐', style: TextStyle(fontSize: 14.sp)),
                ],
              ),
              SizedBox(height: 2.h),
              CustomText(
                title: ConstString.premiumBannerDesc,
                textSize: 14.sp,
                textColor: ConstColor.white,
                maxLine: 1,
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: c.onManagePlan,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                title: ConstString.manage,
                textSize: 12.sp,
                fontWeight: FontWeight.w500,
                textColor: ConstColor.primaryColor,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroVideoCard extends StatelessWidget {
  final ProfileController c;

  const _IntroVideoCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasVideo = c.introVideoPath.value != null;
      final showActions = c.isIntroVideoActionVisible.value;

      // STATE 1: No video uploaded
      if (!hasVideo) {
        return GestureDetector(
          onTap: c.onUploadIntroVideo,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Container(
              width: double.infinity,
              height: 190.h,
              color: ConstColor.primaryColor.withAlpha(60),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      color: ConstColor.primaryColor,
                      size: 32.sp,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      title: ConstString.uploadAVideo,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.primaryColor,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      // STATE 2 & 3: Video exists
      return GestureDetector(
        onTap: showActions ? null : c.onIntroVideoTap,
        onLongPress: c.onIntroVideoLongPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Stack(
            children: [
              AppImage(
                path: 'assets/images/onboarding2_img.jpg',
                width: double.infinity,
                height: 190.h,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 190.h,
                color: Colors.black.withAlpha(showActions ? 130 : 80),
              ),

              // STATE 2: play button (hidden when actions visible)
              if (!showActions)
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: ConstColor.white.withAlpha(100),
                          shape: BoxShape.circle,
                          border: Border.all(color: ConstColor.white),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: ConstColor.white,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomText(
                        title: ConstString.introVideo,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.white,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),

              // STATE 3: Replace / Delete actions
              if (showActions)
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _VideoActionButton(
                        icon: Icons.refresh,
                        label: ConstString.replace,
                        color: ConstColor.primaryColor,
                        onTap: c.onReplaceIntroVideo,
                      ),
                      SizedBox(width: 24.w),
                      _VideoActionButton(
                        icon: Icons.delete,
                        label: ConstString.replace,
                        color: Colors.redAccent,
                        onTap: c.onDeleteIntroVideo,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class _VideoActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _VideoActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: ConstColor.white, size: 22.sp),
          ),
          SizedBox(height: 6.h),
          CustomText(
            title: label,
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.white,
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final ProfileController c;

  const _AboutSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(ConstString.about),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _AboutChip(
                  icon: 'assets/icons/social_icon.svg',
                  label: ConstString.preference,
                  value: c.preferenceLabel.value,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _AboutChip(
                  icon: 'assets/icons/energy_icon.svg',
                  label: ConstString.energy,
                  value: c.energyLabel.value,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _AboutChip(
                  icon: 'assets/icons/clock_icon.svg',
                  label: ConstString.travel,
                  value: c.travelLabel.value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutChip extends StatelessWidget {
  final String icon, label, value;

  const _AboutChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 22.w,
            height: 22.h,
            colorFilter: ColorFilter.mode(
              ConstColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 6.h),
          CustomText(
            title: label,
            textSize: 10.sp,
            textColor: ConstColor.grey,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
          SizedBox(height: 2.h),
          CustomText(
            title: value,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _InterestSection extends StatelessWidget {
  final ProfileController c;

  const _InterestSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(ConstString.topInterest),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: c.interests
                .map((i) => _InterestChip(icon: i.icon, label: i.label))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String icon, label;

  const _InterestChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 14.w,
            height: 14.h,
            colorFilter: ColorFilter.mode(
              ConstColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 6.w),
          CustomText(
            title: label,
            textSize: 14.sp,
            textColor: ConstColor.textColor,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _BadgesSection extends StatelessWidget {
  final ProfileController c;

  const _BadgesSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(ConstString.reliabilityBadges),
          SizedBox(height: 12.h),
          ...c.badges.map(
            (b) => _IconRow(icon: b.icon, title: b.title, subtitle: b.subtitle),
          ),
        ],
      ),
    );
  }
}
class _WeeklyAvailabilitySection extends StatelessWidget {
  final ProfileController c;
  const _WeeklyAvailabilitySection({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.weeklyAvailability,
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 12.h),
          _InfoCard(
            icon: 'assets/icons/weekday_icon.svg',
            title: c.availabilityTitle,
            subtitle: c.availabilitySubtitle,
          ),
        ],
      ),
    );
  }
}

// ── Current Mood Section ──
class _CurrentMoodSection extends StatelessWidget {
  final ProfileController c;
  const _CurrentMoodSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.currentMood,
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 12.h),
          _InfoCard(
            emoji: c.moodEmoji,
            title: c.moodTitle,
          ),
        ],
      ),
    );
  }
}

// ── Shared info card (used by both sections) ──
class _InfoCard extends StatelessWidget {
  final String? icon;
  final String? emoji;
  final String title;
  final String? subtitle;

  const _InfoCard({
    this.icon,
    this.emoji,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon or emoji
          if (icon != null)
            SvgPicture.asset(
              icon!,
              width: 24.r,
              height: 24.r,
              colorFilter: const ColorFilter.mode(
                ConstColor.primaryColor,
                BlendMode.srcIn,
              ),
            )
          else if (emoji != null)
            Text(emoji!, style: TextStyle(fontSize: 22.sp)),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  CustomText(
                    title: subtitle!,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 2,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IndicatorsSection extends StatelessWidget {
  final ProfileController c;

  const _IndicatorsSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(ConstString.communityIndicators),
          SizedBox(height: 12.h),
          ...c.indicators.map(
            (i) => _IconRow(
              icon: i.icon,
              title: i.title,
              subtitle: i.subtitle,
              multiLine: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconRow extends StatelessWidget {
  final String icon, title, subtitle;
  final bool multiLine;

  const _IconRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: multiLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: ConstColor.primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 18.w,
                height: 18.h,
                colorFilter: ColorFilter.mode(
                  ConstColor.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                CustomText(
                  title: subtitle,
                  textSize: 12.sp,
                  textColor: ConstColor.grey,
                  maxLine: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunitySection extends StatelessWidget {
  final ProfileController c;

  const _CommunitySection({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(ConstString.community),
          SizedBox(height: 12.h),
          ...c.communities.map(
            (cm) => GestureDetector(
              onTap: () => c.onCommunityTap(cm),
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: AppImage(
                        path: cm.image,
                        width: 47.w,
                        height: 47.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: cm.name,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.black,
                            maxLine: 1,
                          ),
                          CustomText(
                            title: cm.memberCount,
                            textSize: 12.sp,
                            textColor: ConstColor.grey,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20.sp,
                      color: ConstColor.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: text,
      textSize: 18.sp,
      fontWeight: FontWeight.w700,
      textColor: ConstColor.black,
      maxLine: 1,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );
  }
}
