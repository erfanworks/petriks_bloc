import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

class VerifyIdController extends GetxController {
  final selectedIdImage    = Rx<File?>(null);
  final selectedPhotoImage = Rx<File?>(null);
  final _picker = ImagePicker();
  final isFromProfile = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['fromProfile'] == true) {
      isFromProfile.value = true;
    }
  }

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

  void onSkip() {
    if (isFromProfile.value) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.subscriptionScreen, arguments: {'showFreePlan': true});
    }
  }

  void onContinueToVerification() {
    if (isFromProfile.value) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.profilePhotoScreen);
    }
  }

  Future<void> onVerifyIdContinue() async {
    if (isFromProfile.value) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.back();
      AppSnackBar.success("Verified ID");

    } else {
      Get.toNamed(AppRoutes.profilePhotoScreen);
    }
  }

  void onProfilePhotoContinue() {
    if (!hasPhotoImage) {
      _showSnackBar('Profile photo is required');
      return;
    }
    Get.toNamed(AppRoutes.subscriptionScreen, arguments: {'showFreePlan': true});
  }

  void _showSnackBar(String message) {
    AppSnackBar.error(message, seconds: 2);
  }

  void pickIdFromCamera() async {
    final xFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (xFile != null) selectedIdImage.value = File(xFile.path);
  }

  void onIdUploadTap() {
    MediaPickerBottomSheet.show(
      onCamera: () => pickIdFromCamera(),
      onGallery: () => pickIdFromGallery(),
    );
  }
}
