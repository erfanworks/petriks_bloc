import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.helpAndSafety,),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFFFFCDD2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: ConstString.urgentHelpNeeded,
                        textColor: Color(0xFFBA1A1A),
                        textSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        title: ConstString.emergencyNumber,
                        textColor: Color(0xFFBA1A1A),
                        textSize: 12.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right_rounded, color: Color(0xFFBA1A1A), size: 20.sp),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                title: ConstString.helpCenter,
                textColor: ConstColor.black,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // ---- Menu Items ----
          _HelpMenuItem(
            icon: Icons.tips_and_updates_outlined,
            iconColor: const Color(0xFF2563EB),
            title: ConstString.attendanceTips,
            subtitle: ConstString.howToMeetSafely,
            onTap: controller.goToAttendanceTips,
          ),
          _HelpMenuItem(
            icon: Icons.flag_outlined,
            iconColor: const Color(0xFFFF9800),
            title: ConstString.reportProblem,
            subtitle: ConstString.howToMeetSafely,
            onTap: controller.goToReportProblem,
          ),
          _HelpMenuItem(
            icon: Icons.person_remove_outlined,
            iconColor: const Color(0xFFF44336),
            title: ConstString.blockUser,
            subtitle: ConstString.stopSomeoneContacting,
            onTap: controller.goToBlockUser,
          ),
          _HelpMenuItem(
            icon: Icons.support_agent_outlined,
            iconColor: ConstColor.primaryColor,
            title: ConstString.supportContactHelp,
            subtitle: ConstString.chatWithTeam,
            onTap: controller.goToSupportHelp,
          ),
        ],
      ),
    );
  }
}

class _HelpMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HelpMenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textColor: ConstColor.black,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: subtitle,
                    textColor: ConstColor.grey,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: ConstColor.grey, size: 20.sp),
          ],
        ),
      ),
    );
  }
}





// ======================================================
// 4. Block User Screen
// ======================================================
class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.blockUser),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.blockThisUser,
              textColor: ConstColor.black,
              textSize: 16.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
            SizedBox(height: 14.h),

            // ---- User Info ----
            Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/person1_img.jpg',
                        width: 48.w,
                        height: 48.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5.w),
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 10.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: 'Blocking',
                      textColor: ConstColor.primaryColor,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: 'Marcus Chen',
                      textColor: ConstColor.black,
                      textSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.h),

            CustomText(
              title: ConstString.whatHappensBlock,
              textColor: ConstColor.black,
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
            SizedBox(height: 12.h),

            _BlockInfoCard(
              icon: Icons.visibility_off_outlined,
              iconColor: Colors.red,
              title: ConstString.mutualPrivacy,
              desc: ConstString.mutualPrivacyDesc,
            ),
            _BlockInfoCard(
              icon: Icons.block_outlined,
              iconColor: Colors.red,
              title: ConstString.noContact,
              desc: ConstString.noContactDesc,
            ),
            _BlockInfoCard(
              icon: Icons.shield_outlined,
              iconColor: Colors.red,
              title: ConstString.safeEnvironment,
              desc: ConstString.safeEnvironmentDesc,
            ),

            const Spacer(),

            CustomElevatedButton(
              onPressed: controller.blockUser,
              height: 54,
              top: 0,
              buttonBorderRadius: 30,
              gradient: const [Color(0xFF7B5EA7), Color(0xFF5B2D8E)],
              child: CustomText(
                title: ConstString.block,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _BlockInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String desc;

  const _BlockInfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  textColor: ConstColor.black,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  title: desc,
                  textColor: ConstColor.grey,
                  textSize: 12.sp,
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

// ======================================================
// 5. Support & Help Screen
// ======================================================
class SupportHelpScreen extends StatelessWidget {
  const SupportHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.supportHelp),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              fromTitle: ConstString.subject,
              textController: controller.supportSubjectController,
              validator: (_) => null,
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              fromTitle: ConstString.description,
              textController: controller.supportDescController,
              maxLine: 8,
              validator: (_) => null,
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: controller.submitSupport,
              height: 54,
              top: 0,
              buttonBorderRadius: 30,
              gradient: const [Color(0xFF7B5EA7), Color(0xFF5B2D8E)],
              child: CustomText(
                title: ConstString.submit,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
