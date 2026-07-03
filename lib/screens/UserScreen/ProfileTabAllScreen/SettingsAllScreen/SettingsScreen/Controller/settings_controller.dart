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
  void onTravelTimeTap()           => Get.toNamed(AppRoutes.travelTimeScreen);
  void onVibeSocialEnergyTap()     => Get.toNamed(AppRoutes.vibeSocialEnergyScreen);
  void onWeeklyAvailability()     => Get.toNamed(AppRoutes.weeklyAvailabilityScreen);
  void onCurrentMood()     => Get.toNamed(AppRoutes.currentMoodScreen);
  void onMeetPreferenceTap()       => Get.toNamed(AppRoutes.meetPreferenceScreen);
  void onBlockListTap()            => Get.toNamed(AppRoutes.blockUserListScreen);
  void onTermsConditionTap()       => Get.toNamed(AppRoutes.termsConditionScreen);
  void onPrivacyPolicyTap()        => Get.toNamed(AppRoutes.privacyPolicyScreen);

  void onPushNotificationToggle(bool value) {
    pushNotificationsEnabled.value = value;
    // TODO
  }
}
