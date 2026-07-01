import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class CreateProfileController extends GetxController {
  // Step tracking
  final currentStep = 0.obs;
  static const int totalSteps = 8;

  // Step 1
  final firstNameController = TextEditingController();
  final lastNameController  = TextEditingController();
  final dobController = TextEditingController();
  final selectedGender = ''.obs;
  final selectedDob = Rx<DateTime?>(null);
  final selectedAgeBand = ''.obs;
  final locationText = ''.obs;
  final locationSearchController = TextEditingController();

  final List<String> genderOptions = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];
  final List<String> ageBands = ['18 - 24', '25 - 34', '35 - 44', '45+'];

  void selectDob(DateTime picked) {
    selectedDob.value = picked;
    dobController.text =
        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
  }

  // Step 2
  final selectedInterests = <String>{}.obs;
  final List<Map<String, String>> interests = [
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Art & Museums', 'icon': 'assets/icons/art_icon.svg'},
    {'label': 'Fitness', 'icon': 'assets/icons/fitness_icon.svg'},
    {'label': 'Board games', 'icon': 'assets/icons/board_game_icon.svg'},
    {'label': 'Food', 'icon': 'assets/icons/food_icon.svg'},
  ];

  // Step 3
  final selectedLanguages = <String>{}.obs;
  final preferredChatLanguage = ''.obs;
  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Japanese',
    'Hindi',
    'Arabic',
    'Portuguese',
    'Italian',
  ];
  final List<String> chatLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Japanese',
    'Hindi',
    'Arabic',
    'Portuguese',
    'Italian',
  ];

  // Step 4
  final selectedMeetPref = ''.obs;
  final List<Map<String, String>> meetOptions = [
    {
      'label': '1:1',
      'desc': 'Focused, personal conversations for deeper connection.',
      'icon': 'assets/icons/person_icon.svg',
    },
    {
      'label': 'Small group',
      'desc': 'Dynamic interactions with 3-5 like-minded people.',
      'icon': 'assets/icons/person_group_icon.svg',
    },
    {
      'label': 'Both',
      'desc': "I'm open to all types of discovery and social experiences.",
      'icon': 'assets/icons/both_person_icon.svg',
    },
  ];

  // Step 5
  final selectedVibe = ''.obs;
  final List<Map<String, String>> vibeOptions = [
    {
      'label': 'Quiet',
      'desc':
          'You prefer low-key, intimate settings and deep one-on-one conversations.',
      'icon': 'assets/icons/quit_icon.svg',
    },
    {
      'label': 'Easygoing',
      'desc':
          "A balanced mix—you're comfortable in groups but also enjoy calm moments.",
      'icon': 'assets/icons/easygoing_icon.svg',
    },
    {
      'label': 'Social',
      'desc':
          'You thrive in active environments and love meeting new groups of people.',
      'icon': 'assets/icons/person_group_icon.svg',
    },
    {
      'label': 'Lively',
      'desc':
          'High energy! You enjoy loud music, big crowds, and vibrant social scenes.',
      'icon': 'assets/icons/lively_icon.svg',
    },
  ];

  // Step 6
  final selectedAvailability = ''.obs;
  final List<Map<String, String>> availabilityOptions = [
    {
      'label': 'Weekday evenings',
      'desc': 'Perfect for after-work hangouts and dinners.',
      'icon': 'assets/icons/weekday_icon.svg',
    },
    {
      'label': 'Weekend mornings',
      'desc': 'Coffee, markets, and early adventures.',
      'icon': 'assets/icons/weekend_morning_icon.svg',
    },
    {
      'label': 'Flexible',
      'desc': "My schedule changes often. I'm open!",
      'icon': 'assets/icons/flexible_icon.svg',
    },
  ];

  // Step 7
  final selectedMood = ''.obs;
  final List<Map<String, String>> moodOptions = [
    {'label': 'Get out of the house', 'emoji': '🏠'},
    {'label': 'Talk to someone', 'emoji': '💬'},
    {'label': 'Do something calm', 'emoji': '🙏'},
    {'label': 'Do something active', 'emoji': '⚡'},
    {'label': 'Laugh more', 'emoji': '😄'},
    {'label': 'Try something new', 'emoji': '✨'},
    {'label': 'Meet people in my language', 'emoji': '🌍'},
  ];

  // Step 8
  final currentLocation = 'London, United Kingdom'.obs;
  final selectedTransport = 'Driving'.obs;
  final commuteMinutes = 15.0.obs;

  final List<String> transportOptions = ['Walking', 'Driving'];

  // Slider labels
  final List<String> sliderLabels = ['5m', '20m', '40m', 'Flexible'];

  // Validation per step
  bool get isCurrentStepValid {
    switch (currentStep.value) {
      case 0:
        return firstNameController.text.trim().isNotEmpty &&
            lastNameController.text.trim().isNotEmpty &&
            selectedGender.value.isNotEmpty &&
            selectedDob.value != null &&
            selectedAgeBand.value.isNotEmpty;
      case 1:
        return selectedInterests.length >= 3;
      case 2:
        return selectedLanguages.isNotEmpty ||
            preferredChatLanguage.value.isNotEmpty;
      case 3:
        return selectedMeetPref.value.isNotEmpty;
      case 4:
        return selectedVibe.value.isNotEmpty;
      case 5:
        return selectedAvailability.value.isNotEmpty;
      case 6:
        return selectedMood.value.isNotEmpty;
      case 7:
        return selectedTransport.value.isNotEmpty;
      default:
        return false;
    }
  }

  void onNext() {
    if (!isCurrentStepValid) {
      AppSnackBar.error("Please make a selection to continue", seconds: 2);
      return;
    }
    nextStep();
  }

  // Navigation
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      // Last step → go to verify ID screen
      Get.toNamed(AppRoutes.verifyIdScreen);
    }
  }

  void selectAgeBand(String band) => selectedAgeBand.value = band;

  void toggleInterest(String item) {
    selectedInterests.contains(item)
        ? selectedInterests.remove(item)
        : selectedInterests.add(item);
  }

  void toggleLanguage(String lang) {
    selectedLanguages.contains(lang)
        ? selectedLanguages.remove(lang)
        : selectedLanguages.add(lang);
  }

  void selectMeetPref(String pref) => selectedMeetPref.value = pref;

  void selectVibe(String vibe) => selectedVibe.value = vibe;

  void selectAvailability(String avail) => selectedAvailability.value = avail;

  void selectMood(String mood) => selectedMood.value = mood;

  void selectTransport(String t) => selectedTransport.value = t;

  void setCommute(double val) => commuteMinutes.value = val;

  void editLocation() {
    // TODO: open location picker
  }

  String get commuteLabelDisplay {
    final v = commuteMinutes.value.toInt();
    if (v >= 60) return 'Flexible';
    final unit = selectedTransport.value == 'Walking' ? 'mins' : 'km';
    return '$v $unit';
  }

  @override
  void onInit() {
    firstNameController.addListener(() {
      selectedAgeBand.refresh();
      currentStep.refresh();
    });
    lastNameController.addListener(() {
      selectedAgeBand.refresh();
      currentStep.refresh();
    });

    super.onInit();
  }


  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationSearchController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
