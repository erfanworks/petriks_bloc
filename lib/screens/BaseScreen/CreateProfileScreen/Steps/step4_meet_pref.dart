// ── Step 4: How do you prefer to meet? ──
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';
class Step4MeetPref extends StatelessWidget {
  const Step4MeetPref({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.howToYouPerfect,
      subtitle:
      ConstString.thisHelpsYouConnect,
      child: Obx(() => Column(
        children: c.meetOptions.map((opt) {
          final selected = c.selectedMeetPref.value == opt['label'];
          return SelectableOptionCard(
            label: opt['label']!,
            description: opt['desc']!,
            isSelected: selected,
            showSelectedBadge: true,
            onTap: () => c.selectMeetPref(opt['label']!),
            iconWidget: SvgPicture.asset(
              opt['icon']!,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                selected ? Colors.white : const Color(0xFF6C5CE7),
                BlendMode.srcIn,
              ),
            ),
          );
        }).toList(),
      )),
    );
  }
}