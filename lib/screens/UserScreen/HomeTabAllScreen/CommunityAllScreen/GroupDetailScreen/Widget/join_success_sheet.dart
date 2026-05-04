import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

class JoinedSuccessDialog extends StatelessWidget {
  const JoinedSuccessDialog({
    super.key,
    required this.communityName,
    required this.onGoToChat,
    required this.onBackToDiscovery,
  });

  final String communityName;
  final VoidCallback onGoToChat;
  final VoidCallback onBackToDiscovery;

  static void show(
      BuildContext context, {
        required String communityName,
        required VoidCallback onGoToChat,
        required VoidCallback onBackToDiscovery,
      }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(120),
      builder: (_) => JoinedSuccessDialog(
        communityName: communityName,
        onGoToChat: onGoToChat,
        onBackToDiscovery: onBackToDiscovery,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ConstColor.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.r,
              height: 70.r,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: ConstColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_rounded,
                      color: Colors.white, size: 22.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            CustomText(
              title: "You're in! 🎉",
              textSize: 20.sp,
              fontWeight: FontWeight.w800,
              textColor: ConstColor.black,
              textAlign: TextAlign.center,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),

            SizedBox(height: 8.h),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: ConstColor.iconColor,
                  fontFamily: 'Roboto',
                ),
                children: [
                  const TextSpan(text: 'Welcome to '),
                  TextSpan(
                    text: communityName,
                    style: TextStyle(
                      color: ConstColor.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                    ),
                  ),
                  const TextSpan(
                    text:
                    '. You can now participate in discussions and join upcoming plans.',
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            CustomElevatedButton(
              top: 0,
              onPressed: onGoToChat,
              color: ConstColor.primaryColor,
              buttonBorderRadius: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title: 'Go to Community Chat',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.white,
                    maxLine: 1,
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.chat_bubble_outline_rounded,
                      color: Colors.white, size: 16.r),
                ],
              ),
            ),

            CustomElevatedButton(
              top: 8,
              onPressed: onBackToDiscovery,
              color: Colors.white,
              buttonBorderRadius: 30,
              borderColor: ConstColor.borderColor,
              child: CustomText(
                title: 'Back to Discovery',
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}