import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../../../constant/const_color.dart';
import '../../../../../../../constant/const_string.dart';
import '../../../../../../../widget/AppDialog/app_dialog.dart';

class CompetitionExperienceController extends GetxController {
  final RxInt selectedRating = 0.obs;
  final reviewController = TextEditingController();

  final winningTeamName = ConstString.defaultLeagueName.obs;
  final leagueName = ConstString.defaultLeagueName.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      winningTeamName.value = args['teamName']?.toString() ?? 'Group A';
      leagueName.value = args['leagueName']?.toString() ?? ConstString.defaultLeagueName;
    } else {
      winningTeamName.value = 'Group A';
      leagueName.value = ConstString.defaultLeagueName;
    }
  }

  void onStarTap(int index) {
    selectedRating.value = index + 1;
  }

  void onSubmitReview() {
    AppDialog.show(
      icon: Icons.thumb_up_alt_rounded,
      iconColor: ConstColor.primaryColor,
      iconBackgroundColor: ConstColor.primaryColor.withAlpha(30),
      title: ConstString.reviewGreatTitle,
      message: ConstString.reviewThankYouMessage,
      primaryButtonText: ConstString.doneLabel,
      onPrimaryTap: () {
        Get.back();
        Get.offAllNamed(AppRoutes.navBar, arguments: 0);
      },
      autoDismissDuration: const Duration(seconds: 4),
      onAutoDismiss: () => Get.offAllNamed(AppRoutes.navBar, arguments: 0),
    );
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }
}