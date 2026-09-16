import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.faq,
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: "Frequently Asked Questions",
              textSize: 22.sp,
              fontWeight: FontWeight.w700,
              textColor: ConstColor.black,
              maxLine: 2,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
            SizedBox(height: 8.h),
            CustomText(
              title: "Find answers to common questions about using GoodNiva.",
              textSize: 14.sp,
              textColor: ConstColor.textColor,
              maxLine: 2,
            ),
            SizedBox(height: 24.h),
            _FAQItem(
              question: "How do I join a plan?",
              answer: "Browse the discovery feed, find a plan that interests you, and tap 'Join Event'. Some plans might require host approval.",
            ),
            _FAQItem(
              question: "Is GoodNiva free to use?",
              answer: "GoodNiva offers a free tier with basic features. For advanced features like creating communities and unlimited group joins, we offer GoodNiva Plus.",
            ),
            _FAQItem(
              question: "How can I verify my account?",
              answer: "Go to Settings > Account & Verification and follow the steps to verify your identity. Verification helps build trust within the community.",
            ),
            _FAQItem(
              question: "What is a 'Vibe'?",
              answer: "Vibes are social preferences that help us match you with compatible people and plans. You can manage your vibe in Settings.",
            ),
            _FAQItem(
              question: "How do I report a problem?",
              answer: "You can report issues directly from a user's profile or a plan's detail page. Alternatively, use 'Support / Contact Help' in Settings.",
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: CustomText(
            title: question,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.black,
            maxLine: 2,
          ),
          iconColor: ConstColor.primaryColor,
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          children: [
            CustomText(
              title: answer,
              textSize: 14.sp,
              textColor: ConstColor.textColor,
              maxLine: 10,
            ),
          ],
        ),
      ),
    );
  }
}
