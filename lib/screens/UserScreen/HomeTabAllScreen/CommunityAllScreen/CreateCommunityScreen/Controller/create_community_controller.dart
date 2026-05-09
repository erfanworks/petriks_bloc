import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';

import '../../../../../../routes/app_routes/app_routes.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

class CreateCommunityController extends GetxController {
  final currentStep = 0.obs;
  static const totalSteps = 3;

  final selectedCategory = ''.obs;

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'Sports Community',
      'desc': 'Football, badminton, fitness groups, or team training.',
      'icon': 'assets/icons/sports_icon.svg',
      'bgColor': const Color(0xFFEEEBFF),
      'iconColor': const Color(0xFF6C5CE7),
      'tag': '',
    },
    {
      'label': 'Social Community',
      'desc': 'Coffee meetups, casual hangouts, and networking events.',
      'icon': 'assets/icons/person_group_icon.svg',
      'bgColor': const Color(0xFFFFF0E5),
      'iconColor': const Color(0xFFE07B4F),
      'tag': '',
    },
    {
      'label': 'Custom Community',
      'desc': 'Fully flexible setup. Build exactly what you have in mind.',
      'icon': 'assets/icons/custom_community_icon.svg',
      'bgColor': const Color(0xFFE5F4FF),
      'iconColor': const Color(0xFF0562FC),
      'tag': 'GUIDED',
    },
  ];

  //Step 2
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final nameText = ''.obs;
  final descText = ''.obs;

  final RxString coverPhotoPath = ''.obs;
  final ImagePicker _picker = ImagePicker();


  void pickCoverPhoto() {
    MediaPickerBottomSheet.show(
      onCamera: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) coverPhotoPath.value = photo.path;
      },
      onGallery: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
        if (photo != null) coverPhotoPath.value = photo.path;
      },
    );
  }

  //Step 3
  final selectedInterest = ''.obs;

  final List<Map<String, String>> interests = [
    {'label': 'Coffee',     'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Walk',       'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Football',   'icon': 'assets/icons/football_icon.svg'},
    {'label': 'Boar Games', 'icon': 'assets/icons/game_icon.svg'},
    {'label': 'Workout',    'icon': 'assets/icons/work_out_icon.svg'},
    {'label': 'Just Chill', 'icon': 'assets/icons/chill_icon.svg'},
  ];

  void selectCategory(String label) => selectedCategory.value = label;
  void selectInterest(String label)  => selectedInterest.value = label;

  bool get canProceed {
    if (currentStep.value == 0) {
      return selectedCategory.value.isNotEmpty;
    } else if (currentStep.value == 1) {
      return nameText.value.trim().isNotEmpty &&
          descText.value.trim().isNotEmpty &&
          coverPhotoPath.value.isNotEmpty;
    } else if (currentStep.value == 2) {
      return selectedInterest.value.isNotEmpty;
    }
    return false;
  }

  void nextStep() {
    if (!canProceed) return;

    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      AppSnackBar.success("Success! \nCommunity Created Successfully",seconds: 3);


      currentStep.value = 0;
      selectedCategory.value = '';
      selectedInterest.value = '';
      coverPhotoPath.value = '';
      nameController.clear();
      descController.clear();
      nameText.value = '';
      descText.value = '';

      Get.offAllNamed(AppRoutes.navBar);
    }
  }

  String get buttonLabel =>
      currentStep.value == totalSteps - 1 ? 'Confirm' : 'Continue';

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }
}