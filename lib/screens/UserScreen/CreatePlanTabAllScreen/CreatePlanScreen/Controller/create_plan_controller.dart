import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/const_string.dart';

class CreatePlanController extends GetxController {
  final currentStep = 0.obs;
  static const totalSteps = 4;

  //Step 1
  final selectedPlanType = ''.obs;

  final List<Map<String, dynamic>> planTypes = [
    {
      'label': 'Easy Start',
      'desc': 'Quick, low-pressure 1:1 meetups. Perfect for coffee or a quiet walk.',
      'icon': 'assets/icons/cofee_icon.svg',
      'bgColor': const Color(0xFFF1F8E9),
      'iconColor': const Color(0xFF2E7D32),
      'tag': 'QUICKEST',
      'tagColor': const Color(0xFF2E7D32),
      'tagBg': const Color(0xFFE8F5E9),
      'showArrow': true,
    },
    {
      'label': 'Group Plan',
      'desc': 'Gather a small circle for a one-off activity like board games or football.',
      'icon': 'assets/icons/person_group_icon.svg',
      'bgColor': const Color(0xFFEEEBFF),
      'iconColor': const Color(0xFF6C5CE7),
      'tag': 'POPULAR',
      'tagColor': const Color(0xFF6C5CE7),
      'tagBg': const Color(0xFFEEEBFF),
      'showArrow': false,
    },
    {
      'label': 'Custom Plan',
      'desc': 'Have a unique idea? Use our guided builder to set up your perfect meetup.',
      'icon': 'assets/icons/custom_community_icon.svg',
      'bgColor': const Color(0xFFE5F4FF),
      'iconColor': const Color(0xFF0562FC),
      'tag': 'GUIDED',
      'tagColor': const Color(0xFF0562FC),
      'tagBg': const Color(0xFFE5F4FF),
      'showArrow': false,
    },
  ];

  //Step 2:
  final selectedActivity = ''.obs;

  final List<Map<String, String>> activities = [
    {'label': 'Coffee',     'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Walk',       'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Football',   'icon': 'assets/icons/football_icon.svg'},
    {'label': 'Boar Games', 'icon': 'assets/icons/game_icon.svg'},
    {'label': 'Workout',    'icon': 'assets/icons/work_out_icon.svg'},
    {'label': 'Just Chill', 'icon': 'assets/icons/chill_icon.svg'},
  ];

  //Step 3
  final selectedVibe      = ''.obs;
  final selectedGroupSize = ''.obs;
  final selectedBudget    = ''.obs;
  final selectedGender    = ''.obs;
  final selectedAgeBand   = ''.obs;
  final selectedLanguage  = ''.obs;

  final vibes      = ['Make new friends', 'Casual hangout', 'Beginner-friendly', 'Practice / Skill', 'Deep talks', 'Active'];
  final groupSizes = ['1:1', '2-4', '5-8', '10+'];
  final budgets    = ['Free', '\$10', '\$15', 'Custom'];
  final ageBands   = ['18 - 24', '25 - 34', '35 - 44', '45+'];
  final genders    = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  final languages  = ['English', 'Spanish', 'French', 'German', 'Mandarin'];

  // ── Step 4: When/Where ──
  final planTitleController = TextEditingController(text: 'Coffee Time');
  final selectedDate        = 'Saturday, Nov 24'.obs;
  final selectedTime1       = '07:00 PM'.obs;
  final selectedTime2       = '08:00 PM'.obs;
  final selectedLocation    = 0.obs; // index
  final voteOnTime          = true.obs;
  final voteOnPlace         = true.obs;
  final autoLock            = true.obs;

  final List<Map<String, String>> locations = [
    {'name': 'Blue Bottle Coffee', 'sub': '8 min away',  'image': 'assets/images/party_img.png'},
    {'name': 'Central Park',       'sub': '8 min walk',  'image': 'assets/images/location_img1.jpg'},
  ];
  void onDateSelected(DateTime date) {
    selectedDate.value = '${date.day} ${_month(date.month)}, ${date.year}';
  }

  void onTimeSelected(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    selectedTime1.value = '$hour:$minute $period';
  }

  String _month(int m) => ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m];

  // Navigation
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      Get.back();
    }
  }

  String get buttonLabel =>
      currentStep.value == totalSteps - 1 ? ConstString.complete : ConstString.next;

  @override
  void onClose() {
    planTitleController.dispose();
    super.onClose();
  }
}