import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class VerifyIdController extends GetxController {
  final selectedIdImage    = Rx<File?>(null);
  final selectedPhotoImage = Rx<File?>(null);
  final _picker = ImagePicker();

  bool get hasIdImage    => selectedIdImage.value != null;
  bool get hasPhotoImage => selectedPhotoImage.value != null;

  Future<void> pickIdFromGallery() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (xFile != null) selectedIdImage.value = File(xFile.path);
  }

  Future<void> pickPhotoFromCamera() async {
    final xFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (xFile != null) selectedPhotoImage.value = File(xFile.path);
  }

  Future<void> pickPhotoFromGallery() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (xFile != null) selectedPhotoImage.value = File(xFile.path);
  }

  void onVerifyIdContinue() {
    if (!hasIdImage) {
      _showSnackBar('Image is required');
      return;
    }
    Get.toNamed(AppRoutes.profilePhotoScreen);
  }

  void onProfilePhotoContinue() {
    if (!hasPhotoImage) {
      _showSnackBar('Profile photo is required');
      return;
    }
    Get.toNamed(AppRoutes.subscriptionScreen);
  }

  void _showSnackBar(String message) {
    AppSnackBar.message(message,backgroundColor: ConstColor.primaryColor,seconds: 2);
  }
}