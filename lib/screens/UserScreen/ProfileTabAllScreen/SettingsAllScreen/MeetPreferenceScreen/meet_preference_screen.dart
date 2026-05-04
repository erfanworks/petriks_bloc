import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/widget/CustomElevatedButton/custom_elevated_button.dart';

import '../../../../../Widget/text/custom_text.dart' show CustomText;
import '../../../../../constant/const_color.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/meet_preference_controller.dart';

class MeetPreferenceScreen extends StatelessWidget {
  const MeetPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MeetPreferenceController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.meetPreferenceTitle, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: c.options.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, i) {
                final opt = c.options[i];
                final isSelected = c.selectedMeet.value == opt.title;
                return _MeetCard(option: opt, isSelected: isSelected, onTap: () => c.onMeetSelected(opt.title));
              },
            )),
          ),
          _SaveButton(onSave: c.onSave),
        ],
      ),
    );
  }
}

class _MeetCard extends StatelessWidget {
  final MeetOption option;
  final bool isSelected;
  final VoidCallback onTap;
  const _MeetCard({required this.option, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final iconBg = Color(option.colorValue);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Card ──
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: ConstColor.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? ConstColor.primaryColor : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58.w,
                  height: 58.h,
                  decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      option.icon,
                      width: 20.w,
                      height: 20.h,
                      colorFilter: ColorFilter.mode(
                        isSelected?ConstColor.white:ConstColor.primaryColor,
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
                        title: option.title,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        textColor: ConstColor.black,
                        maxLine: 1,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: option.description,
                        textSize: 14.sp,
                        textColor: ConstColor.grey,
                        maxLine: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isSelected)
            Positioned(
              top: -1,
              right: -1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                ),
                child: CustomText(
                  title: ConstString.selectedLabel,
                  textSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  textColor: ConstColor.white,
                  maxLine: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onSave;
  const _SaveButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.backgroundColor,
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        5.h + MediaQuery.of(context).padding.bottom,
      ),
      child: CustomElevatedButton(
        onPressed: onSave,
        gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
        height: 48,
        top: 0,
        buttonBorderRadius: 30,
        child: CustomText(title: ConstString.save, textSize: 16.sp, fontWeight: FontWeight.w600, textColor: ConstColor.white, maxLine: 1),
      ),
    );
  }
}