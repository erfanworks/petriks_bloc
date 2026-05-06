import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'FeedbackController/feedback_controller.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FeedbackController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.feedback, showBack: true),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0.h,
          16.w,
          24.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.onCreateAgain,
          height: 52,
          top: 0,
          buttonBorderRadius: 30,
          child: CustomText(
            title: ConstString.createAgain,
            textColor: ConstColor.white,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              path: 'assets/images/party_place_img.jpg',
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),

            Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.black.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomText(
                            title: c.planTitle.value,
                            textSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor: ConstColor.black,
                            maxLine: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      _FreeTag(),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          label: c.planLocation.value,
                        ),
                        _InfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: '${c.planDate.value}  🌿 ${c.planVibe.value}',
                          isVibe: true,
                        ),
                        _InfoRow(
                          icon: Icons.language_rounded,
                          label: c.planLanguage.value,
                        ),
                        _InfoRow(
                          icon: Icons.people_outline_rounded,
                          label: c.planType.value,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEDD5),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CustomText(
                        title: ConstString.completed,
                        textSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        textColor: const Color(0xFFEA8C00),
                        maxLine: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _SectionTitle(title: ConstString.hereWhatPeopleShared),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => _StatCard(
                        emoji: '😊',
                        label: ConstString.overAllVibe,
                        value: c.overallVibe.value,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Obx(
                      () => _StatCard(
                        emoji: '👥',
                        label: ConstString.attended,
                        value: '${c.attended.value} People',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Obx(
                      () => _StatCard(
                        emoji: '⭐',
                        label: ConstString.positive,
                        value: c.positive.value,
                        valueColor: ConstColor.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            _SectionTitle(title: ConstString.overallFeelings),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: c.feelings
                    .map((f) => _FeelingRow(feeling: f))
                    .toList(),
              ),
            ),
            SizedBox(height: 20.h),

            _SectionTitle(title: ConstString.whoJoined),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _AvatarRow(users: c.joinedUsers),
            ),
            SizedBox(height: 100.h),
          ],
        ),
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
        color: ConstColor.primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ConstColor.primaryColor.withAlpha(60)),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isVibe;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.isVibe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: ConstColor.primaryColor),
          SizedBox(width: 6.w),
          Expanded(
            child: CustomText(
              title: label,
              textSize: 13.sp,
              textColor: isVibe ? ConstColor.primaryColor : ConstColor.grey,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      child: CustomText(
        title: title,
        textSize: 16.sp,
        fontWeight: FontWeight.w700,
        textColor: ConstColor.black,
        maxLine: 1,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji, label, value;
  final Color? valueColor;

  const _StatCard({
    required this.emoji,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ConstColor.black.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 22.sp)),
          SizedBox(height: 6.h),
          CustomText(
            title: label,
            textSize: 11.sp,
            textColor: ConstColor.grey,
            maxLine: 1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          CustomText(
            title: value,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            textColor: valueColor ?? ConstColor.primaryColor,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

class _FeelingRow extends StatelessWidget {
  final FeelingModel feeling;

  const _FeelingRow({required this.feeling});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Text(feeling.emoji, style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 8.w),
          SizedBox(
            width: 60.w,
            child: CustomText(
              title: feeling.label,
              textSize: 13.sp,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: feeling.progress,
                minHeight: 6.h,
                backgroundColor: ConstColor.borderColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ConstColor.primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 16.w,
            child: CustomText(
              title: feeling.count.toString(),
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.black,
              maxLine: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarRow extends StatelessWidget {
  final List<JoinedUser> users;

  const _AvatarRow({required this.users});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.r,
      child: Stack(
        children: List.generate(
          users.length,
          (i) => Positioned(
            left: i * 32.w,
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ConstColor.white, width: 2),
              ),
              child: ClipOval(
                child: AppImage(
                  path: users[i].image,
                  width: 44.r,
                  height: 44.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
