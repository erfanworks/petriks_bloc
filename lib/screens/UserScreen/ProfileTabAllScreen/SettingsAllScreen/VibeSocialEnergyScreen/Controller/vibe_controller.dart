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
    VibeOption(icon: 'assets/icons/person_icon.svg',    title: 'Social',    description: 'You thrive in active environments and love meeting new groups of people.'),
    VibeOption(icon: 'assets/icons/lively_icon.svg',    title: 'Lively',    description: 'High energy! You enjoy loud music, big crowds, and vibrant social scenes.'),
  ].obs;

  void onVibeSelected(String vibe) => selectedVibe.value = vibe;

  void onSave() async {
    // TODO
    Get.back();
  }
}

class MeetOption {
  final String icon;
  final String title;
  final String description;
  final int colorValue;
  const MeetOption({required this.icon, required this.title, required this.description, required this.colorValue});
}

class MeetPreferenceController extends GetxController {
  final selectedMeet = 'Both'.obs;

  final options = const <MeetOption>[
    MeetOption(icon: 'assets/icons/one_on_one_ic.svg', title: '1:1',         description: 'Focused, personal conversations for deeper connection.',              colorValue: 0xFFEDE9FE),
    MeetOption(icon: 'assets/icons/group_ic.svg',      title: 'Small group', description: 'Dynamic interactions with 3-5 like-minded people.',                   colorValue: 0xFFFEF3C7),
    MeetOption(icon: 'assets/icons/both_ic.svg',       title: 'Both',        description: 'I\'m open to all types of discovery and social experiences.',          colorValue: 0xFF6C5CE7),
  ].obs;

  void onMeetSelected(String meet) => selectedMeet.value = meet;

  void onSave() async {
    // TODO
    Get.back();
  }
}