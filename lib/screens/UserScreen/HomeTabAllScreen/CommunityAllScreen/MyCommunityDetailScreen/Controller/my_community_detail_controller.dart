import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../MyCommunityScreen/Controller/my_community_controller.dart';

// ---- Models ----
class GroupItem {
  final String image;
  final String name;
  final String memberCount;

  const GroupItem({
    required this.image,
    required this.name,
    required this.memberCount,
  });
}

class CompetitionItem {
  final String emoji;
  final String title;
  final String status;
  final bool isUpcoming;

  const CompetitionItem({
    required this.emoji,
    required this.title,
    required this.status,
    required this.isUpcoming,
  });
}

class ProgressTeam {
  final String position;
  final String emoji;
  final String name;
  final String city;
  final int matches;
  final int wins;
  final int draws;
  final int losses;

  const ProgressTeam({
    required this.position,
    required this.emoji,
    required this.name,
    required this.city,
    required this.matches,
    required this.wins,
    required this.draws,
    required this.losses,
  });
}

class JoinableGroup {
  final String image;
  final String name;
  final String activeMembers;
  final RxBool isSelected;

  JoinableGroup({
    required this.image,
    required this.name,
    required this.activeMembers,
  }) : isSelected = false.obs;
}

// ---- Community Detail Controller ----
class MyCommunityDetailController extends GetxController {
  final communityItem = Rxn<MyCommunityModel>();
  final isOwner = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is MyCommunityModel) {
      communityItem.value = Get.arguments;
      isOwner.value =
          (Get.arguments as MyCommunityModel).role.toLowerCase() == 'owner';
    }
  }

  // ---- Groups ----
  final List<GroupItem> groups = [
    const GroupItem(
      image: 'assets/images/football_play.jpg',
      name: 'Morning Runners',
      memberCount: '1,248',
    ),
    const GroupItem(
      image: 'assets/images/fotball_img.jpg',
      name: 'Morning Runners',
      memberCount: '1,248',
    ),
  ];

  // ---- Progress Table ----
  final List<ProgressTeam> progressTeams = [
    const ProgressTeam(
      position: '01',
      emoji: '⚡',
      name: 'Neon Vipers',
      city: 'Chicago 3',
      matches: 12,
      wins: 11,
      draws: 1,
      losses: 0,
    ),
    const ProgressTeam(
      position: '02',
      emoji: '🌅',
      name: 'Morning Run',
      city: 'Chicago 2',
      matches: 12,
      wins: 11,
      draws: 1,
      losses: 0,
    ),
    const ProgressTeam(
      position: '03',
      emoji: '⚡',
      name: 'Neon Vipers',
      city: 'Chicago 1',
      matches: 12,
      wins: 11,
      draws: 1,
      losses: 0,
    ),
  ];

  final List<CompetitionItem> competitions = [
    const CompetitionItem(
      emoji: '🚀',
      title: 'Creative Sprint 2024',
      status: 'Upcoming (Starts in 2d)',
      isUpcoming: true,
    ),
    const CompetitionItem(
      emoji: '🧁',
      title: 'Winter Showcase',
      status: 'Completed Jan 15',
      isUpcoming: false,
    ),
  ];

  // ── Edit Community ──
  final coverImagePath = ''.obs;
  final nameController = TextEditingController(text: 'Coffee Time');
  final descController = TextEditingController(
    text:
        'We are a collective of high-performance movers who treat the concrete as our playground.',
  );

  final availableLanguages = const [
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
  final selectedLanguages = <String>['English', 'Spanish'].obs;
  final preferredLanguage = 'English'.obs;

  void addLanguage(String lang) {
    if (!selectedLanguages.contains(lang)) selectedLanguages.add(lang);
  }

  void removeLanguage(String lang) => selectedLanguages.remove(lang);

  final allInterests = const [
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_icon.svg'},
    {'label': 'Art & Museums', 'icon': 'assets/icons/art_icon.svg'},
    {'label': 'Fitness', 'icon': 'assets/icons/fitness_icon.svg'},
    {'label': 'Board games', 'icon': 'assets/icons/board_game_icon.svg'},
    {'label': 'Food', 'icon': 'assets/icons/food_icon.svg'},
  ];
  final selectedInterests = <Map<String, String>>[
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_icon.svg'},
  ].obs;

  void toggleInterest(Map<String, String> item) {
    final exists = selectedInterests.any((s) => s['label'] == item['label']);
    if (exists) {
      selectedInterests.removeWhere((s) => s['label'] == item['label']);
    } else {
      selectedInterests.add(item);
    }
  }

  Future<void> pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) coverImagePath.value = picked.path;
  }

  Future<void> pickFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) coverImagePath.value = picked.path;
  }

  void onSave() {
    if (nameController.text.trim().isEmpty) {
      AppSnackBar.error('Community name cannot be empty');
      return;
    }
    Get.back();
    AppSnackBar.success('Community updated successfully! ✅');
  }

  // ---- Actions ----
  void onViewGroup(GroupItem item) =>
      Get.toNamed(AppRoutes.myGroupDetailScreen);

  void toCreateGroup() => Get.toNamed(AppRoutes.createGroupScreen);

  void toCreateCompetition() => Get.toNamed(AppRoutes.chooseGroupsScreen);

  // Edit Community
  void onEditCommunity() {
    Get.toNamed(AppRoutes.editCommunityScreen);
  }
  void onDeleteCommunity() {
    Get.back();
    AppSnackBar.success("Competition deleted successfully.");
  }

  // Edit Group
  void onEditGroup() {
    // Get.toNamed(AppRoutes.editCommunityScreen);
  }

  void onDeleteGroup() {
    Get.back();
    // AppSnackBar.success("Competition deleted successfully.");
  }

  void confirmJoinGroup() {
    Get.back();
  }

  void goToCommunityChat() => Get.back();

  void backToDiscovery() => Get.back();
}

// class JoinSuccessSheet extends StatelessWidget {
//   const JoinSuccessSheet({super.key});
//   @override
//   Widget build(BuildContext context) => const SizedBox.shrink();
// }
