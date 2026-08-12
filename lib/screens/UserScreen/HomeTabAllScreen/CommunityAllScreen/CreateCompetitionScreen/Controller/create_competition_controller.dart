import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppDialog/app_dialog.dart';
import '../../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

// ---- Models ----
class CompetitionGroup {
  final String image;
  final String name;
  final String memberCount;
  final RxBool isSelected;

  CompetitionGroup({
    required this.image,
    required this.name,
    required this.memberCount,
  }) : isSelected = false.obs;
}

class ActivityItem {
  final String icon;
  final String name;

  const ActivityItem({required this.icon, required this.name});
}

// ---- Controller ----
class CreateCompetitionController extends GetxController {
  // ---- Step 1: Choose Groups ----
  final RxList<CompetitionGroup> groups = <CompetitionGroup>[
    CompetitionGroup(
      image: 'assets/images/location_img2.jpg',
      name: 'Urban Cyclists',
      memberCount: '24 members',
    ),
    CompetitionGroup(
      image: 'assets/images/hank_out_party_img.jpg',
      name: 'Summit Strikers',
      memberCount: '24 members',
    ),
    CompetitionGroup(
      image: 'assets/images/hank_out_park_party_img.jpg',
      name: 'Morning Flow',
      memberCount: '18 members',
    ),
    CompetitionGroup(
      image: 'assets/images/location_img2.jpg',
      name: 'Garden Collective',
      memberCount: '32 members',
    ),
    CompetitionGroup(
      image: 'assets/images/location_img2.jpg',
      name: 'Tech Nomads',
      memberCount: '156 members',
    ),
  ].obs;

  // max 2 group select
  void toggleGroup(CompetitionGroup group) {
    final selectedCount = groups.where((g) => g.isSelected.value).length;
    if (!group.isSelected.value && selectedCount >= 2) return;
    group.isSelected.value = !group.isSelected.value;
  }

  // ---- Step 2: Select Activity ----
  final List<ActivityItem> activities = const [
    ActivityItem(icon: 'assets/icons/football.svg', name: 'Football'),
    ActivityItem(icon: 'assets/icons/basket_ball_icon.svg', name: 'Basketball'),
    ActivityItem(icon: 'assets/icons/cricket_icon.svg', name: 'Cricket'),
    ActivityItem(icon: 'assets/icons/badminton_icon.svg', name: 'Badminton'),
    ActivityItem(icon: 'assets/icons/volley_ball_icon.svg', name: 'Volleyball'),
    ActivityItem(icon: 'assets/icons/badminton_icon.svg', name: 'Tennis'),
  ];

  final RxInt selectedActivity = (-1).obs;

  void selectActivity(int index) => selectedActivity.value = index;

  // ---- Validations ----
  bool get isStep1Valid => groups.where((g) => g.isSelected.value).length == 2;
  bool get isStep2Valid => selectedActivity.value != -1;
  bool get isStep3Valid =>
      competitionTitle.value.trim().isNotEmpty &&
      selectedMatchLocationNames.isNotEmpty &&
      selectedDate.value.isNotEmpty &&
      selectedTime.value.isNotEmpty;

  // ---- Step 3: Match Locations ----
  final RxList<Map<String, String>> matchLocations = <Map<String, String>>[
    {'name': 'Astro Turf', 'sub': '0.4 miles away', 'desc': 'Perfect for 5-a-side football matches, floodlights included', 'discount': '10% off for GoodNiva users', 'image': 'assets/images/party_img.png'},
    {'name': 'Green Fields Arena', 'sub': '0.4 miles away', 'desc': 'Excellent grass conditions, seating arrangement.', 'discount': '10% off for GoodNiva users', 'image': 'assets/images/location_img1.jpg'},
  ].obs;
  final RxSet<String> selectedMatchLocationNames = <String>{}.obs;

  void toggleMatchLocation(String name) {
    if (selectedMatchLocationNames.contains(name)) {
      selectedMatchLocationNames.remove(name);
    } else {
      selectedMatchLocationNames.add(name);
    }
  }

  // ── Custom Match Location (user added) ──
  final customMatchLocationNameController = TextEditingController();
  final customMatchLocationAddressController = TextEditingController();
  final customMatchLocationSubtitleController = TextEditingController();
  final customMatchLocationImagePath = ''.obs;
  final customMatchLocationFormTick = 0.obs;
  bool get showMatchPlaceVoting => selectedMatchLocationNames.length >= 2;

  void pickCustomMatchLocationImage(String path) {
    customMatchLocationImagePath.value = path;
  }

  bool get canAddCustomMatchLocation =>
      customMatchLocationNameController.text.trim().isNotEmpty &&
          customMatchLocationAddressController.text.trim().isNotEmpty &&
          customMatchLocationImagePath.value.isNotEmpty;

  void addCustomMatchLocation() {
    if (!canAddCustomMatchLocation) return;

    // Insert at the front (index 0) → custom locations show first
    matchLocations.insert(0, {
      'name': customMatchLocationNameController.text.trim(),
      'sub': customMatchLocationAddressController.text.trim(),
      'desc': customMatchLocationSubtitleController.text.trim(),
      'discount': '',
      'image': customMatchLocationImagePath.value,
      'isCustom': 'true',
    });

    // reset form
    customMatchLocationNameController.clear();
    customMatchLocationAddressController.clear();
    customMatchLocationSubtitleController.clear();
    customMatchLocationImagePath.value = '';
  }

  final titleController = TextEditingController(text: 'Football Match');
  final RxString competitionTitle = 'Football Match'.obs;
  final notesController = TextEditingController();
  final capacityController = TextEditingController();
  final RxString selectedDate = 'Saturday, Nov 24'.obs;
  final RxString selectedTime = '07:00 PM'.obs;
  final descriptionController = TextEditingController();
  final uploadImage = ''.obs;

  // ── Vote Duration ──
  final voteDurationIndex = 0.obs;
  final voteDurations = ['1h', '3h', '6h', '12h', '24h', '48h'];
  final customDuration = ''.obs;

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

  Future<void> _pickDescriptionImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      uploadImage.value = file.path;
    }
  }

  void pickDescriptionPhoto() {
    MediaPickerBottomSheet.show(
      onGallery: () => _pickDescriptionImage(ImageSource.gallery),
      onCamera: () => _pickDescriptionImage(ImageSource.camera),
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ConstColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),

            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value =
      '${_weekday(picked.weekday)}, ${_month(picked.month)} ${picked.day}';
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ConstColor.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),

            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      selectedTime.value = '$hour:$minute $period';
    }
  }

  void showSuccessDialog() {
    AppDialog.show(
      icon: Icons.check,
      iconColor: ConstColor.primaryColor,
      iconBackgroundColor: ConstColor.primaryColor.withAlpha(30),
      title: "You're all set! 🎉",
      message: 'Your competition has been successfully scheduled.',
      buttons: [
        AppDialogButton(
          label: ConstString.viewCompetition,
          gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          onTap: () {
            Get.back();
            Get.toNamed(AppRoutes.viewCompetitionScreen);
          },
        ),
        AppDialogButton(
          label: ConstString.backToCommunity,
          backgroundColor: Colors.white,
          textColor: ConstColor.black,
          isOutlined: true,
          onTap: () {
            Get.back();
            Get.toNamed(AppRoutes.navBar);
          },
        ),
      ],
    );
  }

  String _weekday(int d) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d - 1];

  String _month(int m) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];

  // ---- Navigation ----
  void goToSelectActivity() {
    if (isStep1Valid) {
      Get.toNamed(AppRoutes.selectActivityScreen);
    } else {
      AppSnackBar.error("Please select exactly 2 groups to continue.");
    }
  }

  void goToMatchDetails() {
    if (isStep2Valid) {
      Get.toNamed(AppRoutes.setMatchDetailsScreen);
    } else {
      AppSnackBar.error("Please select an activity to continue.");
    }
  }

  void goToFinalReview() {
    if (isStep3Valid) {
      Get.toNamed(AppRoutes.finalReviewScreen);
    } else {
      if (competitionTitle.value.trim().isEmpty) {
        AppSnackBar.error("Please enter a competition title.");
      } else if (selectedMatchLocationNames.isEmpty) {
        AppSnackBar.error("Please select at least one match location.");
      } else {
        AppSnackBar.error("Please fill in all required fields.");
      }
    }
  }

  void goToPublish() => Get.toNamed("AppRoutes.selectActivityScreen");

  void viewCompetition() => Get.back();

  void backToCommunity() => Get.back();

  @override
  void onInit() {
    super.onInit();
    selectedMatchLocationNames.clear();
    titleController.addListener(() => competitionTitle.value = titleController.text);
    customMatchLocationNameController.addListener(_bumpCustomMatchLocationTick);
    customMatchLocationAddressController.addListener(_bumpCustomMatchLocationTick);
  }

  void _bumpCustomMatchLocationTick() => customMatchLocationFormTick.value++;

  @override
  void onClose() {
    titleController.dispose();
    notesController.dispose();
    capacityController.dispose();
    descriptionController.dispose();
    customMatchLocationNameController.dispose();
    customMatchLocationAddressController.dispose();
    customMatchLocationSubtitleController.dispose();
    super.onClose();
  }
}