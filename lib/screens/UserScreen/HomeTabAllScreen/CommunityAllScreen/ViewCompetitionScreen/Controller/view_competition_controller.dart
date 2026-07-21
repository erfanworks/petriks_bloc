import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppDialog/app_dialog.dart';

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


  void onRegister() {
    final teamName = rosterGroups[0].name;

    AppDialog.show(
      icon: Icons.assignment_ind_outlined,
      iconBackgroundColor: ConstColor.primaryColor.withAlpha(30),
      iconColor: ConstColor.primaryColor,
      title: 'Register Confirmation',
      titleColor: const Color(0xFF2E7D32),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: ConstColor.textColor,
          ),
          children: [
            const TextSpan(text: 'You are about to register for this competition as a member of '),
            TextSpan(
              text: teamName,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ConstColor.black),
            ),
          ],
        ),
      ),
      secondaryButtonText: ConstString.cancel,
      onSecondaryTap: () => Get.back(),
      primaryButtonText: ConstString.confirm,
      onPrimaryTap: () {
        Get.back();
        _showRegisterSuccessDialog(teamName);
      },
    );
  }

  void _showRegisterSuccessDialog(String teamName) {
    AppDialog.show(
      icon: Icons.check,
      iconBackgroundColor: const Color(0xFF22C55E),
      iconColor: Colors.white,
      title: 'Awesome!',
      titleColor: ConstColor.grey,
      message: "You're successfully registered",
      primaryButtonText: 'Done',
      onPrimaryTap: () {
        Get.back();
        backToHome();
      },
      autoDismissDuration: const Duration(seconds: 3),
      onAutoDismiss: backToHome,
    );
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