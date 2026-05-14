import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LanguagePreferenceController extends GetxController {
  final allLanguages = const [
    'English', 'Spanish', 'French', 'German',
    'Mandarin', 'Japanese', 'Hindi', 'Arabic',
    'Portuguese', 'Italian',
  ];

  final selectedLanguages = <String>['English', 'Spanish'].obs;

  final selectedChatLanguage = RxString('');

  final isDropdownOpen = false.obs;

  void onLanguageToggle(String lang) {
    if (selectedLanguages.contains(lang)) {
      if (selectedLanguages.length > 1) selectedLanguages.remove(lang);
    } else {
      selectedLanguages.add(lang);
    }
  }

  void onChatLanguageSelected(String lang) {
    selectedChatLanguage.value = lang;
    isDropdownOpen.value = false;
  }

  void onSave() async {
    // TODO
    Get.back();
  }
}