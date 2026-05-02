import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/vibe_controller.dart';

class VibeSocialEnergyScreen extends StatelessWidget {
  const VibeSocialEnergyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VibeSocialEnergyController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.vibeSocialEnergyTitle, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: c.options.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, i) {
                final opt = c.options[i];
                final isSelected = c.selectedVibe.value == opt.title;
                return _VibeCard(
                  option: opt,
                  isSelected: isSelected,
                  onTap: () => c.onVibeSelected(opt.title),
                );
              },
            )),
          ),
          _SaveButton(onSave: c.onSave),
        ],
      ),
    );
  }
}

class _VibeCard extends StatelessWidget {
  final VibeOption option;
  final bool isSelected;
  final VoidCallback onTap;
  const _VibeCard({required this.option, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
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
            // Icon in circle
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  option.icon,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: option.title, textSize: 17.sp, fontWeight: FontWeight.w700, textColor: ConstColor.black, maxLine: 1),
                  SizedBox(height: 4.h),
                  CustomText(title: option.description, textSize: 14.sp, textColor: ConstColor.grey, maxLine: 3),
                ],
              ),
            ),
          ],
        ),
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