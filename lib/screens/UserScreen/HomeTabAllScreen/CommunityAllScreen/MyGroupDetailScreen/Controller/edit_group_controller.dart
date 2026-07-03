import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';

import '../../../../../../routes/app_routes/app_routes.dart';

class MyGroupController extends GetxController {
  // ── Cover photo ──
  final coverImagePath = ''.obs;

  // ── Fields ──
  final nameController = TextEditingController(text: 'Morning Runners');
  final descController = TextEditingController(
    text:
        'We are a collective of high- performance movers who treat the concrete as our playground. Pushing urban endurance limits through collaborative training, competitive heat, and shared grit.',
  );

  // ── Group Limit ──
  final groupLimits = const ['1:1', '2-4', '5-8', 'Custom'];
  final selectedLimitIndex = 1.obs; // default: 2-4

  void selectLimit(int index) => selectedLimitIndex.value = index;

  // ── Image Picker ──
  Future<void> pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) coverImagePath.value = picked.path;
  }

  Future<void> pickFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) coverImagePath.value = picked.path;
  }

  // ── Save ──
  void onSave() {
    if (nameController.text.trim().isEmpty) {
      AppSnackBar.error('Group name cannot be empty');
      return;
    }
    AppSnackBar.success('Group updated successfully! ✅');
    // TODO: API call
  }

  void onEditGroup() {
    Get.toNamed(AppRoutes.editGroupScreen);
  }

  void onDeleteGroup() {
    Get.back();
    AppSnackBar.success("Group deleted successfully.");
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }
}
