import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class SettingsController extends GetxController {
  final pushNotificationsEnabled = true.obs;

  void onEditProfileTap()          => Get.toNamed(AppRoutes.editProfileScreen);
  void onPersonalInformationTap()  => Get.toNamed(AppRoutes.editProfileScreen);
  // void onIdentityVerificationTap() => Get.toNamed('/identity-verification');
  void onLanguagePreferencesTap()  => Get.toNamed(AppRoutes.languagePreferenceScreen);
  void onTravelTimeTap()           => Get.toNamed('/travel-time');
  void onVibeSocialEnergyTap()     => Get.toNamed('/vibe-social-energy');
  void onMeetPreferenceTap()       => Get.toNamed('/meet-preference');
  void onBlockListTap()            => Get.toNamed('/block-list');
  void onTermsConditionTap()       => Get.toNamed('/terms-condition');
  void onPrivacyPolicyTap()        => Get.toNamed('/privacy-policy');

  void onPushNotificationToggle(bool value) {
    pushNotificationsEnabled.value = value;
    // TODO
  }
}



// ─── Travel Time Controller ───────────────────────────────────────────────────
class TravelTimeController extends GetxController {
  final currentLocation = '12/A Frisco, USA'.obs;

  // Slider value in minutes (5–60, where 60 = Flexible)
  final commuteMinutes = 15.0.obs;

  // Label shown above slider
  String get commuteLabel {
    if (commuteMinutes.value >= 60) return 'Flexible';
    return commuteMinutes.value.toInt().toString();
  }

  bool get isFlexible => commuteMinutes.value >= 60;

  void onSliderChanged(double value) => commuteMinutes.value = value;

  void onSave() async {
    // TODO: API call to save travel time
    Get.back();
  }
}

// ─── Block User Model ─────────────────────────────────────────────────────────
class BlockedUserModel {
  final String image;
  final String name;
  final String blockedSince;

  const BlockedUserModel({
    required this.image,
    required this.name,
    required this.blockedSince,
  });
}

// ─── Block User Controller ────────────────────────────────────────────────────
class BlockUserController extends GetxController {
  final blockedUsers = <BlockedUserModel>[
    const BlockedUserModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez',  blockedSince: 'Oct 12, 2023'),
    const BlockedUserModel(image: 'assets/images/person2_img.jpg', name: 'Marcus Sterling',  blockedSince: 'Sep 04, 2023'),
    const BlockedUserModel(image: 'assets/images/person3_img.jpg', name: 'Sarah Jenkins',    blockedSince: 'Aug 21, 2023'),
    const BlockedUserModel(image: 'assets/images/person4_img.jpg', name: 'David Chen',       blockedSince: 'Jul 15, 2023'),
  ].obs;

  // Show unblock confirmation bottom sheet
  void onUnblockTap(BlockedUserModel user) {
    Get.bottomSheet(
      _UnblockSheet(user: user, controller: this),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
    );
  }

  // Confirm unblock — remove from list + API call
  void onConfirmUnblock(BlockedUserModel user) async {
    Get.back();
    blockedUsers.remove(user);
    // TODO: API call to unblock user
  }
}

// ─── Unblock Bottom Sheet (UI only, lives here as private widget) ─────────────
class _UnblockSheet extends StatelessWidget {
  final BlockedUserModel user;
  final BlockUserController controller;
  const _UnblockSheet({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Import these in the actual file — shown here for reference
    return const SizedBox.shrink(); // replaced by full UI in block_user_screen.dart
  }
}