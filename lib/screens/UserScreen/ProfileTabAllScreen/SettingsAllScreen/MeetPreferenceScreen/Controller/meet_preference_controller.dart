import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
    MeetOption(icon: 'assets/icons/person_icon.svg', title: '1:1',         description: 'Focused, personal conversations for deeper connection.',              colorValue: 0xFFEDE9FE),
    MeetOption(icon: 'assets/icons/social_icon.svg',      title: 'Small group', description: 'Dynamic interactions with 3-5 like-minded people.',                   colorValue: 0xFFEDE9FE),
    MeetOption(icon: 'assets/icons/both_person_icon.svg',       title: 'Both',        description: 'I\'m open to all types of discovery and social experiences.',          colorValue: 0xFF6C5CE7),
  ].obs;

  void onMeetSelected(String meet) => selectedMeet.value = meet;

  void onSave() async {
    // TODO
    Get.back();
  }
}