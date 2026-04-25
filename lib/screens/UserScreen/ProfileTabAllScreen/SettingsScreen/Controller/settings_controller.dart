import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class SettingsController extends GetxController {
  final pushNotificationsEnabled = true.obs;

  void onEditProfileTap()          => Get.toNamed(AppRoutes.editProfileScreen);
  void onPersonalInformationTap()  => Get.toNamed('/personal-information');
  void onIdentityVerificationTap() => Get.toNamed('/identity-verification');
  void onLanguagePreferencesTap()  => Get.toNamed('/language-preferences');
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

