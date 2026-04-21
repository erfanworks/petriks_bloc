import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  // ── Step tracking ──
  final currentStep = 0.obs;
  static const int totalSteps = 8;

  // ── Step 1: Basic Info ──
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final selectedGender = ''.obs;
  final selectedDob = Rx<DateTime?>(null);
  final selectedAgeBand = ''.obs;
  final locationText = ''.obs;
  final locationSearchController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  final List<String> ageBands = ['18 - 24', '25 - 34', '35 - 44', '45+'];

  void selectDob(DateTime picked) {
    selectedDob.value = picked;
    dobController.text =
    '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
  }

  // ── Step 2: Interests ──
  final selectedInterests = <String>{}.obs;
  final List<Map<String, String>> interests = [
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Art & Museums', 'icon': 'assets/icons/art_icon.svg'},
    {'label': 'Fitness', 'icon': 'assets/icons/fitness_icon.svg'},
    {'label': 'Board games', 'icon': 'assets/icons/board_game_icon.svg'},
    {'label': 'Food', 'icon': 'assets/icons/food_icon.svg'},
  ];

  // ── Step 3: Languages ──
  final selectedLanguages = <String>{}.obs;
  final preferredChatLanguage = ''.obs;
  final List<String> languages = [
    'English', 'Spanish', 'French', 'German',
    'Mandarin', 'Japanese', 'Hindi', 'Arabic',
    'Portuguese', 'Italian', '+ More',
  ];
  final List<String> chatLanguages = [
    'English', 'Spanish', 'French', 'German', 'Mandarin',
  ];

  // ── Step 4: Meet Preference ──
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

  // ── Step 5: Vibe ──
  final selectedVibe = ''.obs;
  final List<Map<String, String>> vibeOptions = [
    {
      'label': 'Quiet',
      'desc': 'You prefer low-key, intimate settings and deep one-on-one conversations.',
      'icon': 'assets/icons/quit_icon.svg',
    },
    {
      'label': 'Easygoing',
      'desc': "A balanced mix—you're comfortable in groups but also enjoy calm moments.",
      'icon': 'assets/icons/easygoing_icon.svg',
    },
    {
      'label': 'Social',
      'desc': 'You thrive in active environments and love meeting new groups of people.',
      'icon': 'assets/icons/person_group_icon.svg',
    },
    {
      'label': 'Lively',
      'desc': 'High energy! You enjoy loud music, big crowds, and vibrant social scenes.',
      'icon': 'assets/icons/lively_icon.svg',
    },
  ];

  // ── Step 6: Availability ──
  final selectedAvailability = ''.obs;
  final List<Map<String, String>> availabilityOptions = [
    {
      'label': 'Weekday evenings',
      'desc': 'Perfect for after-work hangouts and dinners.',
      'icon': 'assets/icons/ic_evening.svg',
    },
    {
      'label': 'Weekend mornings',
      'desc': 'Coffee, markets, and early adventures.',
      'icon': 'assets/icons/ic_morning.svg',
    },
    {
      'label': 'Flexible',
      'desc': "My schedule changes often. I'm open!",
      'icon': 'assets/icons/ic_flexible.svg',
    },
  ];

  // ── Step 7: Mood ──
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

  // ── Step 8: Travel ──
  final currentLocation = '12/A Sanfrisco, USA'.obs;
  final selectedTransport = 'Driving'.obs;
  final commuteMinutes = 15.0.obs;

  final List<String> transportOptions = ['Walking', 'Driving'];
  // Slider labels
  final List<String> sliderLabels = ['5m', '20m', '40m', 'Flexible'];

  // ── Navigation ──
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      // Last step → go to verify ID screen
      Get.toNamed('/verify-id');
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
    return '$v mins';
  }

  @override
  void onClose() {
    nameController.dispose();
    locationSearchController.dispose();
    dobController.dispose();
    super.onClose();
  }

}