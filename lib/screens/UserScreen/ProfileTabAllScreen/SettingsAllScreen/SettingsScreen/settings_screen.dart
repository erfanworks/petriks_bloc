import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SettingsController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.settings, showBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            _Label(ConstString.accountVerification),
            _AccountCard(c: c),
            SizedBox(height: 8.h),
            _Label(ConstString.preferences),
            _PrefsCard(c: c),
            SizedBox(height: 8.h),
            _Label(ConstString.blockedUser),
            _BlockCard(c: c),
            SizedBox(height: 8.h),
            _Label(ConstString.notifications),
            _NotifCard(c: c),
            SizedBox(height: 8.h),
            _Label(ConstString.appInfo),
            _AppInfoCard(c: c),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
      child: CustomText(
        title: text,
        textSize: 18.sp,
        fontWeight: FontWeight.w700,
        textColor: ConstColor.black,
        maxLine: 1,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final SettingsController c;

  const _AccountCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: AppImage(
                        path: 'assets/images/onboarding2_img.jpg',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ConstColor.white,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.check,
                          color: ConstColor.white,
                          size: 8.sp,
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
                      CustomText(
                        title: 'Sophia Chen',
                        textSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.black,
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.sp,
                            color: ConstColor.grey,
                          ),
                          SizedBox(width: 2.w),
                          CustomText(
                            title: 'Greenwich, Braxton.',
                            textSize: 12.sp,
                            textColor: ConstColor.grey,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: c.onEditProfileTap,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 14.w,
                //       vertical: 7.h,
                //     ),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: ConstColor.primaryColor),
                //       borderRadius: BorderRadius.circular(20.r),
                //     ),
                //     child: CustomText(
                //       title: ConstString.editProfile,
                //       textSize: 12.sp,
                //       fontWeight: FontWeight.w500,
                //       textColor: ConstColor.primaryColor,
                //       maxLine: 1,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          _Div(),
          _Tile(
            icon: Icons.person_outline_rounded,
            title: ConstString.personalInformation,
            onTap: c.onPersonalInformationTap,
          ),
          // _Div(),
          // _Tile(
          //   icon: Icons.shield_outlined,
          //   title: ConstString.identityVerification,
          //   onTap: c.onIdentityVerificationTap,
          // ),
        ],
      ),
    );
  }
}

class _PrefsCard extends StatelessWidget {
  final SettingsController c;

  const _PrefsCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _SvgTile(
            icon: 'assets/icons/language_icon.svg',
            title: ConstString.languagePreferences,
            subtitle: ConstString.languagePrefSub,
            onTap: c.onLanguagePreferencesTap,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/travel_icon.svg',
            title: ConstString.travelTime,
            subtitle: ConstString.travelTimeSub,
            onTap: c.onTravelTimeTap,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/energy_icon.svg',
            title: ConstString.vibeSocialEnergy,
            subtitle: ConstString.vibeSub,
            onTap: c.onVibeSocialEnergyTap,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/weekday_icon.svg',
            title: ConstString.weeklyAvailability,
            subtitle: ConstString.weekdaysEvening,
            onTap: c.onWeeklyAvailability,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/chill_icon.svg',
            title: ConstString.currentMood,
            subtitle: ConstString.talkToSomeone,
            onTap: c.onCurrentMood,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/social_icon.svg',
            title: ConstString.meetPreference,
            subtitle: ConstString.meetPrefSub,
            onTap: c.onMeetPreferenceTap,
          ),
        ],
      ),
    );
  }
}

class _BlockCard extends StatelessWidget {
  final SettingsController c;

  const _BlockCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _Tile(
        icon: Icons.block_rounded,
        title: ConstString.yourBlockList,
        onTap: c.onBlockListTap,
      ),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final SettingsController c;

  const _NotifCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            _IconBox(
              child: Icon(
                Icons.notifications_outlined,
                size: 20.sp,
                color: ConstColor.primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.pushNotifications,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: ConstString.pushNotifSub,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
            Obx(
                  () => Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: c.pushNotificationsEnabled.value,
                  onChanged: c.onPushNotificationToggle,
                    thumbColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.white;
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  final SettingsController c;

  const _AppInfoCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        children: [
          _SvgTile(
            icon: 'assets/icons/location_icon.svg',
            title: ConstString.termsCondition,
            subtitle: ConstString.pushNotifSub,
            onTap: c.onTermsConditionTap,
          ),
          _Div(),
          _SvgTile(
            icon: 'assets/icons/email_icon.svg',
            title: ConstString.privacyPolicy,
            subtitle: ConstString.privacyPolicySub,
            onTap: c.onPrivacyPolicyTap,
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}

class _Div extends StatelessWidget {
  const _Div();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: ConstColor.borderColor,
      indent: 16.w,
      endIndent: 16.w,
    );
  }
}

class _IconBox extends StatelessWidget {
  final Widget child;

  const _IconBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(child: child),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _Tile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            _IconBox(
              child: Icon(icon, size: 20.sp, color: ConstColor.primaryColor),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomText(
                title: title,
                textSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: ConstColor.black,
                maxLine: 1,
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
    );
  }
}

class _SvgTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SvgTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            _IconBox(
              child: SvgPicture.asset(
                icon,
                width: 16.w,
                height: 16.h,
                colorFilter: ColorFilter.mode(
                  ConstColor.primaryColor,
                  BlendMode.srcIn,
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
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: subtitle,
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
    );
  }
}
