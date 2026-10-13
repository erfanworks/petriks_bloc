import 'package:get/get.dart';
import '../../../../../../widget/AddCustomLocationSheet/add_custom_location_sheet.dart' as global;
import '../../Controller/my_plan_controller.dart';

void showAddLocationSheet() {
  final c = Get.find<MyPlanController>();
  global.showAddCustomLocationSheet(
    imagePath: c.customLocationImagePath,
    onPickImage: c.pickCustomLocationImage,
    nameController: c.customLocationNameController,
    addressController: c.customLocationAddressController,
    subtitleController: c.customLocationSubtitleController,
    canAdd: () => c.canAddCustomLocation,
    onAdd: c.addCustomLocation,
    formTick: c.customLocationFormTick,
  );
}
