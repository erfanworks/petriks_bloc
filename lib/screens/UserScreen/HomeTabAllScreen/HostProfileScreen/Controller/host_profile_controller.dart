import 'package:get/get.dart';

class HostProfileController extends GetxController {
  // ── Report state ──
  final selectedReason = ''.obs;
  final selectedUrgency = 'High'.obs;
  final isReportSubmitted = false.obs;

  // ── Report options ──
  final List<String> reportReasons = [
    'Inappropriate behavior',
    'Harassment or bullying',
    'Spam or fake account',
    'Unsafe or suspicious activity',
    'Other',
  ];

  final List<String> urgencyLevels = ['Low', 'Medium', 'High'];

  // ── Dummy data (replace with API) ──
  final name = 'Rahim, 26';
  final location = 'Dhaka';
  final languages = 'English, Bangla';
  final bio =
      'Passionate about exploring local culture and finding the best street food in Dhaka. Always up for a friendly cricket match or a tech talk!';
  final followers = '24 Followers';
  final following = '18 Following';
  final mutualCount = '2 mutual connections you both know';
  final isVerified = true;
  final isFollowing = false.obs;

  // ── About stats ──
  final List<Map<String, String>> aboutStats = [
    {'label': 'Preference', 'value': '1:1', 'icon': 'assets/icons/person_group_icon.svg'},
    {'label': 'Energy', 'value': 'Social', 'icon': 'assets/icons/energy_icon.svg'},
    {'label': 'Travel', 'value': 'Flexible', 'icon': 'assets/icons/watch_icon.svg'},
  ];

  // ── Interests ──
  final List<Map<String, String>> interests = [
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_cup_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_outdoors_icon.svg'},
    {'label': 'Art & Museums', 'icon': 'assets/icons/art_icon.svg'},
    {'label': 'Travel', 'icon': 'assets/icons/travel_icon.svg'},
    {'label': 'Cooking', 'icon': 'assets/icons/cooking_icon.svg'},
    {'label': 'Photography', 'icon': 'assets/icons/camera_icon.svg'},
    {'label': 'Live Music', 'icon': 'assets/icons/music_icon.svg'},
  ];

  // ── Reliability badges ──
  final List<Map<String, String>> badges = [
    {'label': 'On-time host', 'sub': '12 Plans', 'icon': 'assets/icons/watch_icon.svg'},
    {'label': 'Inclusive host', 'sub': 'All Welcome', 'icon': 'assets/icons/profile_icon.svg'},
    {'label': 'Quick reply', 'sub': 'Under 2 HR', 'icon': 'assets/icons/energy_icon.svg'},
  ];

  // ── Community indicators ──
  final List<Map<String, String>> communityIndicators = [
    {
      'label': 'Newcomer friendly',
      'sub': 'Actively welcomes members joining for their first time',
      'icon': 'assets/icons/newcommer_icon.svg',
    },
    {
      'label': 'Multilingual host',
      'sub': 'English, Spanish, French',
      'icon': 'assets/icons/translate_icon.svg',
    },
  ];

  // ── Plans ──
  final List<Map<String, String>> plans = [
    {
      'title': 'Weekend Coding Retreat',
      'location': 'Gulshan Innovation Lab',
      'date': 'Saturday, 10:00 AM',
      'tag': 'HOSTED',
    },
    {
      'title': 'Weekend Coding Retreat',
      'location': 'Gulshan Innovation Lab',
      'date': 'Saturday, 10:00 AM',
      'tag': 'HOSTED',
    },
  ];

  // ── Community ──
  final List<Map<String, String>> communities = [
    {'name': 'Urban Athletes', 'sub': '12 Group', 'image': 'assets/images/hank_out_park_party_img.jpg'},
    {'name': 'Urban Athletes', 'sub': '12 Group', 'image': 'assets/images/hank_out_party_img.jpg'},
  ];

  // ── Actions ──
  void toggleFollow() => isFollowing.value = !isFollowing.value;

  void onMessage() => Get.toNamed('/message');

  void selectReason(String reason) => selectedReason.value = reason;

  void selectUrgency(String level) => selectedUrgency.value = level;

  void submitReport() {
    if (selectedReason.value.isEmpty) return;
    isReportSubmitted.value = true;
  }

  void resetReport() {
    selectedReason.value = '';
    selectedUrgency.value = 'High';
    isReportSubmitted.value = false;
  }
}
