import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

class CreateGroupController extends GetxController {

  final ImagePicker _picker = ImagePicker();
  final RxString descriptionPhotoPath = ''.obs;
  final selectedGroupLimit = '2-4'.obs;
  final groupLimits = ['1:1', '2-4', '5-8', 'Custom'];
  final showCustomInput = false.obs;
  final groupNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final customLimitController = TextEditingController();
  final groupNameText = ''.obs;
  final descriptionText = ''.obs;


  bool get canCreate =>
      groupNameText.value.trim().isNotEmpty &&
          descriptionText.value.trim().isNotEmpty &&
          descriptionPhotoPath.value.isNotEmpty &&
          selectedGroupLimit.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
  }


  void selectGroupLimit(String limit) {
    Future.microtask(() {
      selectedGroupLimit.value = limit;
      showCustomInput.value = false;
      customLimitController.clear();
    });
  }

  void updateGroupName(String val) {
    if (groupNameText.value != val) {
      Future.microtask(() => groupNameText.value = val);
    }
  }

  void updateDescription(String val) {
    if (descriptionText.value != val) {
      Future.microtask(() => descriptionText.value = val);
    }
  }

  void submitCustomLimit(String value) {
    if (value.isNotEmpty) {
      Future.microtask(() {
        selectedGroupLimit.value = value;
        showCustomInput.value = false;
      });
    }
  }

  void pickDescriptionPhoto() {
    MediaPickerBottomSheet.show(
      onCamera: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) descriptionPhotoPath.value = photo.path;
      },
      onGallery: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
        if (photo != null) descriptionPhotoPath.value = photo.path;
      },
    );
  }

  void onCreateGroup() {
    if (!canCreate) {
      if (groupNameController.text.trim().isEmpty) {
        AppSnackBar.error("Please enter a group name");
      } else if (descriptionController.text.trim().isEmpty) {
        AppSnackBar.error("Please enter a description");
      } else if (descriptionPhotoPath.value.isEmpty) {
        AppSnackBar.error("Please upload a cover photo");
      } else if (selectedGroupLimit.value.isEmpty) {
        AppSnackBar.error("Please select a group limit");
      }
      return;
    }
    Get.back();
    AppSnackBar.success("Group created successfully 🎉");
  }

  @override
  void onClose() {
    groupNameController.dispose();
    descriptionController.dispose();
    customLimitController.dispose();
    super.onClose();
  }
}
