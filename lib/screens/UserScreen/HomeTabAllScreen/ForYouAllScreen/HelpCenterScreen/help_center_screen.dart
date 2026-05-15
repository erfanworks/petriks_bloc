import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  static final List<_TipData> _tips = [
    _TipData(
      icon: 'assets/icons/cofee_cup_icon.svg',
      iconColor: const Color(0xFF006C49),
      title: 'Meet in Public',
      desc:
          'Always choose busy, well-lit public spaces like cafes or parks for your first few meetups.',
    ),
    _TipData(
      icon: 'assets/icons/location_icon.svg',
      iconColor: const Color(0xFF2765EB),
      title: 'Share Your Plans',
      desc:
          'Tell a friend or family member where you\'re going and who you\'re meeting.',
    ),
    _TipData(
      icon: 'assets/icons/mobile_icon.svg',
      iconColor: const Color(0xFF5341CD),
      title: 'Stay in the App',
      desc:
          'Keep your conversations within the app until you\'re fully comfortable with the other person.',
    ),
    _TipData(
      icon: 'assets/icons/trust_icon.svg',
      iconColor: const Color(0xFFFF9B56),
      title: 'Trust Your Gut',
      desc:
          'If a situation feels uncomfortable or \'off\', you have every right to leave immediately.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.helpAndSafety),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: .30.h,),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBA1A1A).withAlpha(15),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFBA1A1A).withAlpha(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: ConstString.urgentHelpNeeded,
                        textColor: const Color(0xFFBA1A1A),
                        textSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      SizedBox(height: 8.h),
                      ...[
                        ConstString.emergencyNumber1,
                        ConstString.emergencyNumber2,
                        ConstString.emergencyNumber3,
                      ].map(
                        (text) => Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: '• ',
                                textColor: const Color(0xFFBA1A1A),
                                textSize: 14.sp,
                                maxLine: 1,
                              ),
                              Expanded(
                                child: CustomText(
                                  title: text,
                                  textColor: const Color(0xFFBA1A1A),
                                  textSize: 12.sp,
                                  maxLine: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: ConstString.attendanceTips,
                  textColor: ConstColor.black,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            ..._tips.map(
              (tip) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _TipCard(tip: tip),
              ),
            ),
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
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // _HelpMenuItem(
            //   icon: Icons.tips_and_updates_outlined,
            //   iconColor: const Color(0xFF2563EB),
            //   title: ConstString.attendanceTips,
            //   subtitle: ConstString.howToMeetSafely,
            //   onTap: controller.goToAttendanceTips,
            // ),
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
            SizedBox(height: 42.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: controller.goHowDidItGo,
          height: 50,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [
            ConstColor.primaryDeepColor,
            ConstColor.primaryColor,
          ],
          child: CustomText(
            title: ConstString.next,
            textColor: Colors.white,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
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
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
            Icon(
              Icons.chevron_right_rounded,
              color: ConstColor.grey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _TipData {
  final String icon;
  final Color iconColor;
  final String title;
  final String desc;

  _TipData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.desc,
  });
}

// ---- Tip Card ----
class _TipCard extends StatelessWidget {
  final _TipData tip;

  const _TipCard({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ConstColor.borderColor, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Icon Circle ----
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: tip.iconColor.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ConstColor.borderColor, width: 1),
            ),
            child: Center(
              child: SvgPicture.asset(
                tip.icon,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(tip.iconColor, BlendMode.srcIn),
              ),
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: tip.title,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: tip.desc,
                  textColor: ConstColor.grey,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
