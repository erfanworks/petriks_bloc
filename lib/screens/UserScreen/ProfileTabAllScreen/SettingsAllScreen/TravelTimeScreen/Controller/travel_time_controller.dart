import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TravelTimeController extends GetxController {
  final currentLocation = 'City/Town: London'.obs;

  final commuteMinutes = 15.0.obs;

  String get commuteLabel {
    if (commuteMinutes.value >= 60) return 'Flexible';
    return commuteMinutes.value.toInt().toString();
  }

  bool get isFlexible => commuteMinutes.value >= 60;

  void onSliderChanged(double value) => commuteMinutes.value = value;

  void onSave() async {
    // TODO
    Get.back();
  }
}