import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

import '../../../ProfileScreen/Controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final firstNameController = TextEditingController(text: 'Sophia');
  final lastNameController  = TextEditingController(text: 'Chen');
  final bioController       = TextEditingController(text: 'I love exploring new coffee shops and meeting new people!');
  final dateOfBirth        = '12 Aug, 2026'.obs;
  final selectedAgeBand    = '25 - 34'.obs;
  final searchLocationCtrl = TextEditingController();
  final locationLabel      = 'Covet Garden, Soho, Mayfair, Westminster (Big Ben).'.obs;
  final pickedAvatarPath   = ''.obs;
  final isSaving           = false.obs;

  final ageBands = const ['18 - 24', '25 - 34', '35 - 44', '45+'];

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    searchLocationCtrl.dispose();
    super.onClose();
  }

  void onAgeBandSelected(String band) => selectedAgeBand.value = band;

  void onDateOfBirthTap(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 8, 12),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF6C63FF)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      dateOfBirth.value = '${picked.day} ${_month(picked.month)} ${picked.year}';
    }
  }

  void onAvatarTap() {
    MediaPickerBottomSheet.show(
      onGallery: () => pickFromGallery(),
      onCamera: () => pickFromCamera(),
    );
  }

  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) pickedAvatarPath.value = picked.path;
  }

  Future<void> pickFromCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) pickedAvatarPath.value = picked.path;
  }

  void onSave() async {
    try {
      isSaving.value = true;
      await Future.delayed(const Duration(seconds: 1));

      // Update ProfileController if it exists
      if (Get.isRegistered<ProfileController>()) {
        final pc = Get.find<ProfileController>();
        pc.userName.value = '${firstNameController.text}, ${pc.userName.value.split(',').last.trim()}';
        pc.userBio.value = bioController.text;
        pc.userLocation.value = locationLabel.value.split(',').first.trim();
      }

      // G et.back();
      Get.toNamed(AppRoutes.navBar, arguments: 3);
    } catch (_) {
      // TODO: error snack bar
    } finally {
      isSaving.value = false;
    }
  }

  String _month(int m) => ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m];
}