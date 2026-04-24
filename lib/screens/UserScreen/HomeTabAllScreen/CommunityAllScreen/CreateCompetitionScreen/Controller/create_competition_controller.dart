import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../Widget/competition_success_sheet.dart';

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

  final RxInt selectedActivity = 0.obs;

  void selectActivity(int index) => selectedActivity.value = index;

  // ---- Step 3: Match Details ----
  final titleController = TextEditingController(text: 'Football Match');
  final notesController = TextEditingController();
  final RxString selectedDate = 'Saturday, Nov 24'.obs;
  final RxString selectedTime = '07:00 PM'.obs;

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      selectedTime.value = '$hour:$minute $period';
    }
  }

  void showSuccessDialog() {
    Get.dialog(
      CompetitionSuccessDialog(
        communityName: 'Sunday Championship',
        goToViewCompetition: () {
          // Get.back();
          Get.toNamed(AppRoutes.viewCompetitionScreen);
        },
        onBackToCommunity: () {
          Get.toNamed(AppRoutes.communityDetailScreen);
        },
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withAlpha(120),
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
  void goToSelectActivity() => Get.toNamed(AppRoutes.selectActivityScreen);

  void goToMatchDetails() => Get.toNamed(AppRoutes.setMatchDetailsScreen);

  void goToFinalReview() => Get.toNamed(AppRoutes.finalReviewScreen);

  void goToPublish() => Get.toNamed("AppRoutes.selectActivityScreen");

  void viewCompetition() => Get.back();

  void backToCommunity() => Get.back();

  @override
  void onClose() {
    titleController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
