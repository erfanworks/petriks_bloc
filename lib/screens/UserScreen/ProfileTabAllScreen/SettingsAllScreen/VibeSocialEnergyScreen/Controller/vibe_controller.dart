import 'package:get/get.dart';

class VibeOption {
  final String icon;
  final String title;
  final String description;
  const VibeOption({required this.icon, required this.title, required this.description});
}

class VibeSocialEnergyController extends GetxController {
  final selectedVibe = 'Social'.obs;

  final options = const <VibeOption>[
    VibeOption(icon: 'assets/icons/quit_icon.svg',      title: 'Quiet',     description: 'You prefer low-key, intimate settings and deep one-on-one conversations.'),
    VibeOption(icon: 'assets/icons/easygoing_icon.svg',      title: 'Easygoing', description: 'A balanced mix—you\'re comfortable in groups but also enjoy calm moments.'),
    VibeOption(icon: 'assets/icons/person_group_icon.svg',    title: 'Social',    description: 'You thrive in active environments and love meeting new groups of people.'),
    VibeOption(icon: 'assets/icons/lively_icon.svg',    title: 'Lively',    description: 'High energy! You enjoy loud music, big crowds, and vibrant social scenes.'),
  ].obs;

  void onVibeSelected(String vibe) => selectedVibe.value = vibe;

  void onSave() async {
    // TODO
    Get.back();
  }
}

