import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart'; // ─── Make sure this is imported

class CreateGroupController extends GetxController {

  final ImagePicker _picker = ImagePicker();
  final RxString descriptionPhotoPath = ''.obs;
  final selectedGroupLimit = '2-4'.obs;
  final groupLimits = ['1:1', '2-4', '5-8', 'Custom'];
  final showCustomInput = false.obs;
  final customLimitController = TextEditingController();

  void selectGroupLimit(String limit) {
    selectedGroupLimit.value = limit;
    showCustomInput.value = false;
    customLimitController.clear();
  }
  void submitCustomLimit(String value) {
    if (value.isNotEmpty) {
      selectedGroupLimit.value = value;
      showCustomInput.value = false;
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

  @override
  void onClose() {
    customLimitController.dispose(); // মেমরি লিক রোধে ডিসপোজ
    super.onClose();
  }
}