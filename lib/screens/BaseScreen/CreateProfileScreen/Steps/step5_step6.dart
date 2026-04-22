//Step 5:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';

import '../Controller/create_profile_controller.dart';
import '../Widget/step_shell.dart';

class Step5Vibe extends StatelessWidget {
  const Step5Vibe({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.whatsYourVibe,
      subtitle: ConstString.wellMatchYouWithSimilar,
      child: Obx(() => Column(
        children: c.vibeOptions.map((opt) {
          final selected = c.selectedVibe.value == opt['label'];
          return SelectableOptionCard(
            label: opt['label']!,
            description: opt['desc']!,
            isSelected: selected,
            onTap: () => c.selectVibe(opt['label']!),
            iconWidget: SvgPicture.asset(
              opt['icon']!,
              width: 22,
              height: 22,
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

// Step 6:
class Step6Availability extends StatelessWidget {
  const Step6Availability({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateProfileController>();

    return StepShell(
      title: ConstString.whenAreYouUsually,
      subtitle: ConstString.thisHelpsUs,
      child: Obx(() => Column(
        children: c.availabilityOptions.map((opt) {
          final selected = c.selectedAvailability.value == opt['label'];
          return SelectableOptionCard(
            label: opt['label']!,
            description: opt['desc']!,
            isSelected: selected,
            onTap: () => c.selectAvailability(opt['label']!),
            iconWidget: SvgPicture.asset(
              opt['icon']!,
              width: 22,
              height: 22,
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