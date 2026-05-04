import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/const_color.dart';
import '../text/custom_text.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subTitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleSize;
  final Color? backIconColor;
  final bool centerTitle;

  const GlobalAppBar({
    super.key,
    this.title,
    this.subTitle,
    this.showBack = true,
    this.onBack,
    this.leadingWidget,
    this.actions,
    this.backgroundColor = Colors.white,
    this.titleColor = const Color(0xFF1E293B),
    this.subTitleColor = const Color(0xFF64748B),
    this.titleSize,
    this.backIconColor = const Color(0xFF1E293B),
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[

            if (showBack) ...[
              GestureDetector(
                onTap: onBack ?? () => Get.back(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w, top: 8.h, bottom: 8.h),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20.sp,
                    color: backIconColor,
                  ),
                ),
              ),
            ],

            if (leadingWidget != null) ...[
              leadingWidget!,
              SizedBox(width: 12.w),
            ],

            Expanded(
              child: (title != null || subTitle != null)
                  ? Column(
                crossAxisAlignment: centerTitle
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  if (title != null)
                    CustomText(
                      title: title!,
                      textColor: titleColor ?? ConstColor.black,
                      textSize: titleSize ?? 18.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),

                  if (subTitle != null) ...[
                    SizedBox(height: 2.h),
                    CustomText(
                      title: subTitle!,
                      textColor: subTitleColor ?? ConstColor.grey,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ]
                ],
              )
                  : const SizedBox.shrink(),
            ),

            if (actions != null && actions!.isNotEmpty) ...[
              SizedBox(width: 12.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}