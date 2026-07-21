import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';

////// Models
class RosterGroup {
  final String image;
  final String name;
  final String memberCount;
  final List<String> avatars;
  final int extraCount;

  const RosterGroup({
    required this.image,
    required this.name,
    required this.memberCount,
    required this.avatars,
    required this.extraCount,
  });
}

///// Controller
class ViewCompetitionController extends GetxController {
  ///// State
  final RxBool isRegistered = false.obs;
  final RxBool isCompleted = false.obs;
  final isOwner = false.obs;

  void setOwner(bool value) => isOwner.value = value;

  //// Select Winner (0=GroupA, 1=GroupB, 2=Draw)
  final RxInt selectedWinner = 0.obs;

  ///// Notes
  final notesController = TextEditingController();
  final List<RosterGroup> rosterGroups = [
    const RosterGroup(
      image: 'assets/images/hank_out_party_img.jpg',
      name: 'Group A',
      memberCount: '6 Members Registered',
      avatars: [
        'assets/images/person1_img.jpg',
        'assets/images/onboarding5_img.jpg',
        'assets/images/hank_out_party_img.jpg',
      ],
      extraCount: 9,
    ),
    const RosterGroup(
      image: 'assets/images/hank_out_park_party_img.jpg',
      name: 'Group B',
      memberCount: '8 Members Registered',
      avatars: [
        'assets/images/person1_img.jpg',
        'assets/images/onboarding5_img.jpg',
      ],
      extraCount: 6,
    ),
  ];

  ///// Actions
  void onRegister() {
    final teamName = rosterGroups[0].name;
    Get.toNamed(AppRoutes.navBar);
    AppSnackBar.success("You've successfully registered with $teamName for this competition! 🎉", seconds: 3);
  }

  void onMarkCompleted() => Get.toNamed(AppRoutes.addMatchResultScreen);

  void onEditCompetition() => Get.toNamed(AppRoutes.setMatchDetailsScreen);


  void backToHome() =>
  Get.offAllNamed(AppRoutes.navBar, arguments: 0);

  void selectWinner(int index) => selectedWinner.value = index;

  void confirmResult() {
    isCompleted.value = true;
    // Get.back();
    Get.toNamed(AppRoutes.finalScoreScreen);
    AppSnackBar.success("Match result confirmed successfully.✅");
  }

  void onEditResult() => Get.toNamed(AppRoutes.addMatchResultScreen);

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}