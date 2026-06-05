import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';

class CreatePlanController extends GetxController {
  final currentStep = 0.obs;
  final selectedPlanType = ''.obs;
  final selectedPrivacy = 'public'.obs;
  final selectedTime2 = '08:00 PM'.obs;
  final voteDurationIndex = 0.obs;
  final voteDurations = ['1h', '3h', '6h', '12h', '24h', '48h'];
  final customDuration = ''.obs;

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
  ];

  final selectedActivity = ''.obs;

  final List<Map<String, String>> activities = [
    {'label': 'Coffee',     'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Walk',       'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Football',   'icon': 'assets/icons/football_icon.svg'},
    {'label': 'Boar Games', 'icon': 'assets/icons/game_icon.svg'},
    {'label': 'Workout',    'icon': 'assets/icons/work_out_icon.svg'},
    {'label': 'Just Chill', 'icon': 'assets/icons/chill_icon.svg'},
  ];

  final selectedVibe      = ''.obs;
  final selectedGroupSize = ''.obs;
  final selectedBudget    = ''.obs;
  final selectedGender    = ''.obs;
  final selectedAgeBand   = ''.obs;
  final selectedLanguage  = ''.obs;

  final vibes      = ['Quite', 'Social', 'Lively', 'Easy Going',];
  final groupSizes = ['1:1', '2-4', '5-8', '10+'];
  final budgets    = ['Free', '£10', '£15', 'Custom'];
  final ageBands   = ['18 - 24', '25 - 34', '35 - 44', '45+'];
  final genders    = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  final languages  =
  [ 'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Japanese',
    'Hindi',
    'Arabic',
    'Portuguese',
    'Italian',];

  final planTitleController = TextEditingController(text: 'Coffee Time');
  final selectedDate        = 'Saturday, Nov 24'.obs;
  final selectedTime1       = '07:00 PM'.obs;
  final selectedLocation    = (-1).obs;
  final selectedLocations = <int>{}.obs;
  final voteOnTime          = false.obs;
  final voteOnPlace         = true.obs;
  final autoLock            = true.obs;
  final coverPhotoPath = ''.obs;

  final List<Map<String, String>> locations = [
    {'name': 'Blue Bottle Coffee', 'sub': '8 min away',  'image': 'assets/images/party_img.png'},
    {'name': 'Central Park',       'sub': '8 min walk',  'image': 'assets/images/location_img1.jpg'},
  ];

  void onDateSelected(DateTime date) {
    selectedDate.value = '${date.day} ${_month(date.month)}, ${date.year}';
  }
  void toggleLocation(int index) {
    if (selectedLocations.contains(index)) {
      selectedLocations.remove(index);
    } else {
      selectedLocations.add(index);
    }
  }

  void onTimeSelected(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    selectedTime1.value = '$hour:$minute $period';
  }

  void onTime2Selected(TimeOfDay time) {
    final hour   = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    selectedTime2.value = '$hour:$minute $period';
  }


  void onPickCustomDuration(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 2, minute: 0),
      helpText: 'Set custom vote duration',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: ConstColor.primaryColor),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    if (picked.hour == 0 && picked.minute == 0) return;
    final h = picked.hour;
    final m = picked.minute;
    customDuration.value = h > 0 ? (m > 0 ? '${h}h ${m}m' : '${h}h') : '${m}m';
  }

  String _month(int m) => ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m];

  bool get isLastStep {
    if (selectedPlanType.value == 'Easy Start') {
      return currentStep.value == 2; // Step1 + Step3Vibe + Step4WhenWhere = index 2
    } else {
      return currentStep.value == 3; // Step1 + Step2Activity + Step3Vibe + Step4WhenWhere = index 3
    }
  }

  bool get canProceed {
    if (currentStep.value == 0) {
      return selectedPlanType.value.isNotEmpty;
    }

    if (selectedPlanType.value == 'Group Plan') {
      if (currentStep.value == 1) return selectedActivity.value.isNotEmpty;
      if (currentStep.value == 2) {
        return selectedVibe.value.isNotEmpty &&
            selectedGroupSize.value.isNotEmpty &&
            selectedBudget.value.isNotEmpty &&
            selectedGender.value.isNotEmpty &&
            selectedAgeBand.value.isNotEmpty &&
            selectedLanguage.value.isNotEmpty;
      }
      if (currentStep.value == 3) {
        return planTitleController.text.isNotEmpty ;
            // selectedLocation.value != -1;
      }
    } else {
      // Easy Start
      if (currentStep.value == 1) {
        return selectedVibe.value.isNotEmpty &&
            // selectedGroupSize.value.isNotEmpty &&
            selectedBudget.value.isNotEmpty &&
            selectedGender.value.isNotEmpty &&
            selectedAgeBand.value.isNotEmpty &&
            selectedLanguage.value.isNotEmpty;
      }
      if (currentStep.value == 2) {
        return planTitleController.text.isNotEmpty ;
            // selectedLocation.value != -1;
      }
    }
    return false;
  }

  String get buttonLabel => isLastStep ? ConstString.complete : ConstString.next;

  void nextStep() {
    if (!canProceed) return;

    if (isLastStep) {
      AppSnackBar.success("Success! \nYour plan has been created successfully.",seconds: 2);

      currentStep.value = 0;

      selectedPlanType.value = '';
      selectedActivity.value = '';
      selectedVibe.value = '';
      selectedLocation.value = -1;

    } else {
      currentStep.value++;
    }
  }

  @override
  void onClose() {
    planTitleController.dispose();
    super.onClose();
  }
}