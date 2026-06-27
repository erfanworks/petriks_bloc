import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../GroupDetailScreen/Widget/join_success_sheet.dart';

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
class CommunityDetailController extends GetxController {
  final RxBool hasJoined = false.obs;
  final showUpgradeGate = true.obs;
  // ---- Groups ----
  final List<GroupItem> groups = [
    const GroupItem(image: 'assets/images/football_play.jpg', name: 'Morning Runners', memberCount: '1,248'),
    const GroupItem(image: 'assets/images/fotball_img.jpg', name: 'Morning Runners', memberCount: '1,248'),
    const GroupItem(image: 'assets/images/football_play.jpg', name: 'Morning Runners', memberCount: '1,248'),
  ];

  // ---- Progress Table ----
  final List<ProgressTeam> progressTeams = [
    const ProgressTeam(position: '01', emoji: '⚡', name: 'Neon Vipers', city: 'Chicago 3', matches: 12, wins: 11, draws: 1, losses: 0),
    const ProgressTeam(position: '02', emoji: '🌅', name: 'Morning Run', city: 'Chicago 2', matches: 12, wins: 11, draws: 1, losses: 0),
    const ProgressTeam(position: '03', emoji: '⚡', name: 'Neon Vipers', city: 'Chicago 1', matches: 12, wins: 11, draws: 1, losses: 0),
  ];

  // ---- Competitions ----
  final List<CompetitionItem> competitions = [
    const CompetitionItem(emoji: '🚀', title: 'Creative Sprint 2024', status: 'Upcoming (Starts in 2d)', isUpcoming: true),
    const CompetitionItem(emoji: '🧁', title: 'Winter Showcase', status: 'Completed Jan 15', isUpcoming: false),
  ];

  // ---- Join Group ----
  final RxList<JoinableGroup> joinableGroups = <JoinableGroup>[
    JoinableGroup(image: 'assets/images/football_play.jpg', name: 'Urban Sprinters', activeMembers: '42 ACTIVE MEMBERS'),
    JoinableGroup(image: 'assets/images/football_play.jpg', name: 'Trail Blazers', activeMembers: '18 ACTIVE MEMBERS'),
    JoinableGroup(image: 'assets/images/football_play.jpg', name: 'Trail Blazers', activeMembers: '18 ACTIVE MEMBERS'),
    JoinableGroup(image: 'assets/images/football_play.jpg', name: 'Trail Blazers', activeMembers: '18 ACTIVE MEMBERS'),
    JoinableGroup(image: 'assets/images/football_play.jpg', name: 'Trail Blazers', activeMembers: '18 ACTIVE MEMBERS'),
  ].obs;

  // ---- Actions ----
  void onViewGroup(GroupItem item) => Get.toNamed(AppRoutes.groupDetailScreen);

  void onJoinCommunity() => Get.toNamed(AppRoutes.joinGroupScreen);

  void onJoinGroup() => Get.toNamed(AppRoutes.joinGroupScreen);

  void selectGroup(JoinableGroup selected) {
    for (final g in joinableGroups) {
      g.isSelected.value = false;
    }
    selected.isSelected.value = true;
  }

  void confirmJoinGroup(BuildContext context) {

    hasJoined.value = true;

    Get.find<NavbarController>().highlightMyPlan();

    JoinedSuccessDialog.show(
      context,
      communityName: 'Urban Athletes',
      onGoToChat: () {
        Get.back(); // Close dialog first
        Get.toNamed(AppRoutes.directChatScreen);
      },
      onBackToDiscovery: () {
        Get.back(); // Close dialog first
        Get.toNamed(AppRoutes.navBar);
      },
    );
  }

  void goToCommunityChat() => Get.back();

  void backToDiscovery() => Get.back();
}
