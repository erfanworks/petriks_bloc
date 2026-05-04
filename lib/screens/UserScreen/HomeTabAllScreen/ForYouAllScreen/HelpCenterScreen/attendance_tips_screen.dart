import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class AttendanceTipsScreen extends StatelessWidget {
  const AttendanceTipsScreen({super.key});

  static final List<_TipData> _tips = [
    _TipData(
      icon: 'assets/icons/cofee_cup_icon.svg',
      iconColor: const Color(0xFF006C49),
      title: 'Meet in Public',
      desc: 'Always choose busy, well-lit public spaces like cafes or parks for your first few meetups.',
    ),
    _TipData(
      icon: 'assets/icons/location_icon.svg',
      iconColor: const Color(0xFF2765EB),
      title: 'Share Your Plans',
      desc: 'Tell a friend or family member where you\'re going and who you\'re meeting.',
    ),
    _TipData(
      icon: 'assets/icons/mobile_icon.svg',
      iconColor: const Color(0xFF5341CD),
      title: 'Stay in the App',
      desc: 'Keep your conversations within the app until you\'re fully comfortable with the other person.',
    ),
    _TipData(
      icon: 'assets/icons/trust_icon.svg',
      iconColor: const Color(0xFFFF9B56),
      title: 'Trust Your Gut',
      desc: 'If a situation feels uncomfortable or \'off\', you have every right to leave immediately.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.attendanceTips),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.followGuidelines,
              textColor: ConstColor.grey,
              textSize: 15.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
            ),
            SizedBox(height: 16.h),
            ..._tips.map((tip) => _TipCard(tip: tip)),
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
        border: Border.all(color: ConstColor.borderColor,width: 1)
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
              border: Border.all(color: ConstColor.borderColor,width: 1)
            ),
            child: Center(
              child: SvgPicture.asset(
                tip.icon,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  tip.iconColor,
                  BlendMode.srcIn,
                ),
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