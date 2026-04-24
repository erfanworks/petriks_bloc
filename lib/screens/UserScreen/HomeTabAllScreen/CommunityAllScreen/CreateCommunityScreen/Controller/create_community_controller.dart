import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommunityController extends GetxController {
  final currentStep = 0.obs;
  static const totalSteps = 3;

  // ── Step 1: Category ──
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

  // ── Step 2: Details ──
  final nameController = TextEditingController();
  final descController = TextEditingController();

  // ── Step 3: Interests ──
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

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      // TODO: submit
      Get.back();
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