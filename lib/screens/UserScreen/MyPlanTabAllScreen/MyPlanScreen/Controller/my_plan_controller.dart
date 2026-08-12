import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../constant/const_color.dart';

class PlanModel {
  final String id, title, location, date, time, language, type, image, vibe;
  final int joined, total;
  final String? tag;
  final bool isFree;

  const PlanModel({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.language,
    required this.type,
    required this.image,
    required this.vibe,
    required this.joined,
    required this.total,
    this.tag,
    this.isFree = true,
  });
}

class MyPlanController extends GetxController {
  final selectedTab = 0.obs;

  final autoLock      = true.obs;
  final voteOnTime    = true.obs;
  final voteOnPlace   = true.obs;

  final titleController    = TextEditingController(text: 'Hang out at the park');
  final selectedActivity   = 'Coffee'.obs;
  final selectedDate       = 'Saturday, Nov 24'.obs;
  final selectedTime1      = '07:00 PM'.obs;
  final selectedTime2      = '08:00 PM'.obs;

  final activities = ['Coffee', 'Sports', 'Art', 'Outdoors', 'Music'];

  final RxList<Map<String, String>> locations = <Map<String, String>>[
    {'name': 'Bean House Café',  'sub': '0.4 miles away', 'desc': 'Good for small coffee meetups.', 'discount': '10% off for GoodNiva users', 'image': 'assets/images/party_img.png'},
    {'name': 'Central Park',  'sub': 'Manhattan, NY 10024', 'desc': 'Great for outdoor activities.', 'discount': '', 'image': 'assets/images/centarl_park_img.png'},
  ].obs;

  final RxSet<String> selectedLocationNames = {'Central Park'}.obs;

  final customLocationNameController = TextEditingController();
  final customLocationAddressController = TextEditingController();
  final customLocationSubtitleController = TextEditingController();
  final customLocationImagePath = ''.obs;
  final customLocationFormTick = 0.obs;

  void pickCustomLocationImage(String path) {
    customLocationImagePath.value = path;
  }

  bool get canAddCustomLocation =>
      customLocationNameController.text.trim().isNotEmpty &&
          customLocationAddressController.text.trim().isNotEmpty &&
          customLocationImagePath.value.isNotEmpty;

  void addCustomLocation() {
    if (!canAddCustomLocation) return;
    locations.insert(0, {
      'name': customLocationNameController.text.trim(),
      'sub': customLocationAddressController.text.trim(),
      'desc': customLocationSubtitleController.text.trim(),
      'discount': '',
      'image': customLocationImagePath.value,
      'isCustom': 'true',
    });
    selectedLocationNames.add(customLocationNameController.text.trim());
    customLocationNameController.clear();
    customLocationAddressController.clear();
    customLocationSubtitleController.clear();
    customLocationImagePath.value = '';
  }

  void toggleLocation(String name) {
    if (selectedLocationNames.contains(name)) {
      selectedLocationNames.remove(name);
    } else {
      selectedLocationNames.add(name);
    }
  }

  @override
  void onInit() {
    super.onInit();
    customLocationNameController.addListener(_bumpCustomLocationTick);
    customLocationAddressController.addListener(_bumpCustomLocationTick);
  }

  void _bumpCustomLocationTick() => customLocationFormTick.value++;

  final createdPlans = <PlanModel>[
    // const PlanModel(
    //   id: '1', title: 'Hang out at the park',
    //   location: 'Central Park West', date: 'Saturday, 24 June',
    //   time: '6:30 PM Today', language: 'English',
    //   type: 'Group', image: 'assets/images/night_party_img.jpg',
    //   vibe: 'Social', joined: 3, total: 6,
    // ),
    const PlanModel(
      id: '2', title: 'Hang out at the park',
      location: 'Central Park West', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/hank_out_park_party_img.jpg',
      vibe: 'Social', joined: 3, total: 6,
      tag: 'COMPLETED',
    ),
    const PlanModel(
      id: '3', title: 'Hang out at the park',
      location: 'Central Park West', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/hank_out_party_img.jpg',
      vibe: 'Social', joined: 3, total: 6,
      tag: 'BOOST',
    ),
    const PlanModel(
      id: '4', title: 'Hang out at the park',
      location: 'Central Park West', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/hank_out_party_img.jpg',
      vibe: 'Social', joined: 11, total: 6,
      tag: 'BOOSTED',
    ),
  ];

  final joinedPlans = <PlanModel>[
    const PlanModel(
      id: '4', title: 'Hang out at the park',
      location: 'Central Park West', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/hank_out_party_img.jpg',
      vibe: 'Social', joined: 3, total: 6,
    ),
    const PlanModel(
      id: '5', title: 'Hang out at the park',
      location: 'Central Park West, NYC', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/night_party_img.jpg',
      vibe: 'Nature Walk', joined: 6, total: 6, tag: 'COMPLETED',
    ),
    const PlanModel(
      id: '6', title: 'Hang out at the park',
      location: 'Central Park West, NYC', date: 'Saturday, 24 June',
      time: '6:30 PM Today', language: 'English',
      type: 'Group', image: 'assets/images/night_party_img.jpg',
      vibe: 'Nature Walk', joined: 3, total: 6, tag: 'OPEN',
    ),
  ];

  void switchTab(int i) => selectedTab.value = i;

  void goToCreatedDetails(PlanModel plan) =>
      Get.toNamed(AppRoutes.createdPlanDetailsScreen, arguments: plan);

  void goToJoinedDetails(PlanModel plan) =>
      Get.toNamed(AppRoutes.joinedPlanDetailsScreen, arguments: plan);

  void goToEditPlan() => Get.toNamed(
    AppRoutes.editPlanScreen,
    arguments: events,
  );

  // Date picker
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ConstColor.primaryColor,
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    final day = _weekday(picked.weekday);
    final month = _month(picked.month);
    selectedDate.value = '$day, $month ${picked.day}';
  }

// Time picker
  Future<void> pickTime(BuildContext context, {required bool isFirst}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: ConstColor.primaryColor,
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    final formatted = picked.format(context);
    if (isFirst) {
      selectedTime1.value = formatted;
    } else {
      selectedTime2.value = formatted;
    }
  }

  String _weekday(int w) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];

  String _month(int m) =>
      ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];

  @override
  void onClose() {
    // titleController.dispose();
    super.onClose();
  }
}