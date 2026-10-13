import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/CreateProfileScreen/Widget/step_shell.dart';
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Obx(
                () => Column(
                  children: c.options.map((opt) {
                    final isSelected = c.selectedMeet.value == opt.title;
                    return SelectableOptionCard(
                      label: opt.title,
                      description: opt.description,
                      isSelected: isSelected,
                      showSelectedBadge: true,
                      onTap: () => c.onMeetSelected(opt.title),
                      iconWidget: SvgPicture.asset(
                        opt.icon,
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : ConstColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          _SaveButton(onSave: c.onSave),
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
        gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
        height: 48,
        top: 0,
        buttonBorderRadius: 30,
        child: CustomText(
          title: ConstString.save,
          textSize: 16.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.white,
          maxLine: 1,
        ),
      ),
    );
  }
}
