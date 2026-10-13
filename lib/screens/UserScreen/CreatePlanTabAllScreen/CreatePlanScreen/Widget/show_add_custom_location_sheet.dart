import 'package:get/get.dart';
import '../../../../../widget/AddCustomLocationSheet/add_custom_location_sheet.dart' as global;
import '../Controller/create_plan_controller.dart';

void showAddCustomLocationSheet() {
  final c = Get.find<CreatePlanController>();
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
