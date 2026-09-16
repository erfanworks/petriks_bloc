import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/AppImage/app_image.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.aboutUs,
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100.r,
                    height: 100.r,
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/about_icon.svg',
                        width: 50.r,
                        height: 50.r,
                        colorFilter: const ColorFilter.mode(
                          ConstColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    title: "GoodNiva",
                    textSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    textColor: ConstColor.black,
                  ),
                  CustomText(
                    title: "Version 1.0.0",
                    textSize: 14.sp,
                    textColor: ConstColor.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _SectionHeader(title: "Our Mission"),
            SizedBox(height: 12.h),
            _ContentCard(
              text: "At GoodNiva, we believe that real connections improve your week. Our mission is to bridge the gap between digital interaction and real-life social experiences by helping you discover local plans and communities that share your vibe.",
            ),
            SizedBox(height: 24.h),
            _SectionHeader(title: "Why GoodNiva?"),
            SizedBox(height: 12.h),
            _ContentCard(
              text: "We provide a safe, inclusive space for everyone to find their tribe. Whether you're looking for a casual coffee meetup, a team for a weekend football match, or a new social community, GoodNiva is designed to make it easy and safe.",
            ),
            SizedBox(height: 24.h),
            _SectionHeader(title: "Connect With Us"),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [
                  _SocialTile(
                    icon: Icons.language,
                    label: "Website",
                    value: "www.goodniva.com",
                  ),
                  _Divider(),
                  _SocialTile(
                    icon: Icons.email_outlined,
                    label: "Support Email",
                    value: "support@goodniva.com",
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      textSize: 18.sp,
      fontWeight: FontWeight.w700,
      textColor: ConstColor.black,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );
  }
}

class _ContentCard extends StatelessWidget {
  final String text;
  const _ContentCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: CustomText(
        title: text,
        textSize: 14.sp,
        textColor: ConstColor.textColor,
        maxLine: 10,
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SocialTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: ConstColor.primaryColor),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: label,
                textSize: 12.sp,
                textColor: ConstColor.grey,
              ),
              CustomText(
                title: value,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                textColor: ConstColor.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 24.h,
      thickness: 1,
      color: ConstColor.borderColor,
    );
  }
}
