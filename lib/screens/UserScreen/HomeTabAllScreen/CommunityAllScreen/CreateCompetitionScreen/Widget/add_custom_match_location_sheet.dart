import 'package:get/get.dart';
import '../../../../../../widget/AddCustomLocationSheet/add_custom_location_sheet.dart' as global;
import '../Controller/create_competition_controller.dart';

void showAddCustomMatchLocationSheet() {
  final c = Get.find<CreateCompetitionController>();
  global.showAddCustomLocationSheet(
    imagePath: c.customMatchLocationImagePath,
    onPickImage: c.pickCustomMatchLocationImage,
    nameController: c.customMatchLocationNameController,
    addressController: c.customMatchLocationAddressController,
    subtitleController: c.customMatchLocationSubtitleController,
    canAdd: () => c.canAddCustomMatchLocation,
    onAdd: c.addCustomMatchLocation,
    formTick: c.customMatchLocationFormTick,
  );
}
