import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/host_profile_controller.dart';
import 'Widget/report_bottom_sheet.dart';

class HostProfileScreen extends StatelessWidget {
  const HostProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HostProfileController());

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.profile,
        actions: [
          GestureDetector(
            onTap: () => _showOptionsMenu(context, c),
            child: Icon(Icons.more_vert_rounded,
                color: ConstColor.black, size: 22.r),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section 1: Header ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileHeader(c: c),
                  SizedBox(height: 12.h),
                  CustomText(
                    title: c.bio,
                    textSize: 13.sp,
                    textColor: ConstColor.textColor,
                    maxLine: 5,
                  ),
                  SizedBox(height: 12.h),
                  _FollowRow(c: c),
                  SizedBox(height: 14.h),
                  _ActionButtons(c: c),
                  SizedBox(height: 12.h),
                  _MutualConnections(c: c),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 2: Intro Video ──
            _SectionCard(child: _IntroVideo()),

            SizedBox(height: 10.h),

            // ── Section 3: About ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.about),
                  SizedBox(height: 12.h),
                  Row(
                    children: c.aboutStats.map((s) {
                      return Expanded(
                        child: _AboutStatCard(
                          label: s['label']!,
                          value: s['value']!,
                          icon: s['icon']!,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 4: Top Interests ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.topInterest),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: c.interests
                        .map((i) => _InterestChip(
                      label: i['label']!,
                      icon: i['icon']!,
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 5: Reliability Badges ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.reliabilityBadges),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: c.badges
                        .map((b) => _BadgeCard(
                      label: b['label']!,
                      sub: b['sub']!,
                      icon: b['icon']!,
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 6: Community Indicators ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.communityIndicators),
                  SizedBox(height: 12.h),
                  ...c.communityIndicators.map(
                        (ci) => _CommunityIndicatorRow(
                      label: ci['label']!,
                      sub: ci['sub']!,
                      icon: ci['icon']!,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 7: Plans ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.plans),
                  SizedBox(height: 12.h),
                  ...c.plans.map((p) => _PlanCard(plan: p)),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // ── Section 8: Community ──
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(title: ConstString.community),
                  SizedBox(height: 12.h),
                  ...c.communities.map((cm) => _CommunityRow(data: cm)),
                ],
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // ── 3-dot menu: Report / Block ──
  void _showOptionsMenu(BuildContext context, HostProfileController c) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000.w, 60.h, 16.w, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      items: [
        PopupMenuItem(
          child: CustomText(
              title: ConstString.report,
              textSize: 14.sp,
              textColor: ConstColor.black,
              maxLine: 1),
          onTap: () => Future.microtask(
                  () => ReportBottomSheet.show(context, c)),
        ),
        PopupMenuItem(
          child: CustomText(
              title: ConstString.block,
              textSize: 14.sp,
              textColor: ConstColor.black,
              maxLine: 1),
          onTap: () {
            // TODO: block action
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
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
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      textSize: 16.sp,
      fontWeight: FontWeight.w700,
      textColor: ConstColor.black,
      maxLine: 1,
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar with verified badge
        Stack(
          children: [
            ClipOval(
              child: AppImage(
                path: 'assets/images/onboarding2_img.jpg',
                width: 82.r,
                height: 82.r,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 24.r,
                height: 24.r,
                decoration:  BoxDecoration(
                  color: ConstColor.primaryColor,
                  border: Border.all(color: ConstColor.white,width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.verified,
                    color: Colors.white, size: 13.r),
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Verified badge + name row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      title: c.name,
                      textSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: ConstString.verifiedToMeet,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      textColor: ConstColor.primaryColor,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              // Location + language
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location_icon.svg',
                    width: 14.r,
                    height: 14.r,
                    colorFilter: const ColorFilter.mode(
                        ConstColor.primaryColor, BlendMode.srcIn),
                  ),
                  SizedBox(width: 6.w),
                  CustomText(
                    title: '${c.location}  •  ${c.languages}',
                    textSize: 14.sp,
                    textColor: ConstColor.iconColor,
                    fontWeight: FontWeight.w500,
                    maxLine: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FollowRow extends StatelessWidget {
  const _FollowRow({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          title: c.followers,
          textSize: 14.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.primaryColor,
          maxLine: 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
              width: 2, height: 14.h, color: ConstColor.grey),
        ),
        CustomText(
          title: c.following,
          textSize: 14.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.primaryColor,
          maxLine: 1,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => CustomElevatedButton(
            height: 40,
            top: 0,
            onPressed: c.toggleFollow,
            color: c.isFollowing.value
                ? Colors.white
                : ConstColor.primaryColor,
            buttonBorderRadius: 30,
            borderColor: ConstColor.primaryColor,
            child: CustomText(
              title: c.isFollowing.value
                  ? ConstString.following
                  : ConstString.follow,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: c.isFollowing.value
                  ? ConstColor.primaryColor
                  : Colors.white,
              maxLine: 1,
            ),
          )),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomElevatedButton(
            height: 40,
            elevation: 0,
            top: 0,
            onPressed: c.onMessage,
            isOutLined: true,
            outLineColour: ConstColor.primaryColor,
            buttonBorderRadius: 30,
            child: CustomText(
              title: ConstString.message,
              textSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.primaryColor,
              maxLine: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _MutualConnections extends StatelessWidget {
  const _MutualConnections({required this.c});
  final HostProfileController c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Stacked avatars
          SizedBox(
            width: 52.w,
            height: 28.h,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: ClipOval(
                    child: AppImage(
                      path: 'assets/images/onboarding1_img.jpg',
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 18.w,
                  child: ClipOval(
                    child: AppImage(
                      path: 'assets/images/onboarding2_img.jpg',
                      width: 28.r,
                      height: 28.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              title: c.mutualCount,
              textSize: 12.sp,
              textColor: ConstColor.textColor,
              fontWeight: FontWeight.w500,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AppImage(
            path: 'assets/images/hank_out_park_party_img.jpg',
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.cover,
          ),
          // Play button
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              shape: BoxShape.circle,
              border: Border.all(color: ConstColor.white,width: 0.5)
            ),
            child: Icon(Icons.play_arrow_rounded,
                color: ConstColor.white, size: 28.r),
          ),
          // INTRO VIDEO label
          Positioned(
            bottom: 35.h,
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                title: ConstString.introVideo,
                textSize: 11.sp,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                maxLine: 1,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutStatCard extends StatelessWidget {
  const _AboutStatCard({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label, value, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon,
              width: 20.r,
              height: 20.r,
              colorFilter: const ColorFilter.mode(
                  ConstColor.primaryColor, BlendMode.srcIn)),
          SizedBox(height: 6.h),
          CustomText(
            title: label,
            textSize: 11.sp,
            textColor: ConstColor.textColor,
            textAlign: TextAlign.center,
            maxLine: 1,
          ),
          SizedBox(height: 2.h),
          CustomText(
            title: value,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            textAlign: TextAlign.center,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.label, required this.icon});
  final String label, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: ConstColor.boxColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon,
              width: 14.r,
              height: 14.r,
              colorFilter: const ColorFilter.mode(
                  ConstColor.primaryColor, BlendMode.srcIn)),
          SizedBox(width: 5.w),
          CustomText(
            title: label,
            textSize: 12.sp,
            fontWeight: FontWeight.w500,
            textColor: ConstColor.textColor,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard(
      {required this.label, required this.sub, required this.icon});
  final String label, sub, icon;

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 64.w) / 2;
    return Container(
      width: w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        // color: ConstColor.boxColor,
        border: Border.all(color: ConstColor.borderColor,width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon,
              width: 20.r,
              height: 20.r,
              colorFilter: const ColorFilter.mode(
                  ConstColor.primaryColor, BlendMode.srcIn)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: label,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                CustomText(
                  title: sub,
                  textSize: 10.sp,
                  textColor: ConstColor.iconColor,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityIndicatorRow extends StatelessWidget {
  const _CommunityIndicatorRow(
      {required this.label, required this.sub, required this.icon});
  final String label, sub, icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        // color: ConstColor.borderColor,
        border: Border.all(color: ConstColor.borderColor,width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon,
              width: 20.r,
              height: 20.r,
              colorFilter: const ColorFilter.mode(
                  ConstColor.primaryColor, BlendMode.srcIn)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: label,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: sub,
                  textSize: 12.sp,
                  textColor: ConstColor.iconColor,
                  fontWeight: FontWeight.w400,
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

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});
  final Map<String, String> plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        // color: ConstColor.backgroundColor,
        border: Border.all(color: ConstColor.borderColor,width: 1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: plan['title']!,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),
                Row(children: [
                  SvgPicture.asset('assets/icons/location_icon.svg',
                      width: 12.r,
                      height: 12.r,
                      colorFilter: const ColorFilter.mode(
                          ConstColor.primaryDeepColor, BlendMode.srcIn)),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: plan['location']!,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                ]),
                SizedBox(height: 2.h),
                Row(children: [
                  SvgPicture.asset('assets/icons/calender_icon.svg',
                      width: 12.r,
                      height: 12.r,
                      colorFilter: const ColorFilter.mode(
                          ConstColor.primaryColor, BlendMode.srcIn)),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: plan['date']!,
                    textSize: 14.sp,
                    textColor: ConstColor.textColor,
                    maxLine: 1,
                  ),
                ]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // HOSTED tag
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 11.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE9E67).withAlpha(120),
                  borderRadius: BorderRadius.circular(19.r),
                ),
                child: CustomText(
                  title: plan['tag']!,
                  textSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  textColor: const Color(0xFF773403),
                  maxLine: 1,
                ),
              ),
              SizedBox(height: 22.h),
              // Stacked member avatars
              SizedBox(
                width: 60.w,
                height: 24.h,
                child: Stack(
                  children: [
                    ...List.generate(2, (i) => Positioned(
                      left: (i * 14).w,
                      child: ClipOval(
                        child: AppImage(
                          path: 'assets/images/onboarding4_img.jpg',
                          width: 24.r,
                          height: 24.r,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    Positioned(
                      left: 28.w,
                      child: Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: CustomText(
                            title: '+12',
                            textSize: 8.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            maxLine: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityRow extends StatelessWidget {
  const _CommunityRow({required this.data});
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ConstColor.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: AppImage(
              path: data['image']!,
              width: 46.r,
              height: 46.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: data['name']!,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.black,
                  maxLine: 1,
                ),
                CustomText(
                  title: data['sub']!,
                  textSize: 12.sp,
                  textColor: ConstColor.grey,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: ConstColor.black, size: 20.r),
        ],
      ),
    );
  }
}