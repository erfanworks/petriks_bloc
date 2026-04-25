import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  final pushNotificationsEnabled = true.obs;

  void onEditProfileTap()          => Get.toNamed('/edit-profile');
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

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController(text: 'Sophia Chen');
  final dateOfBirth        = '12 Aug, 2026'.obs;
  final selectedAgeBand    = '25 - 34'.obs;
  final searchLocationCtrl = TextEditingController();
  final locationLabel      = 'San Francisco, CA — Based on your current location'.obs;
  final pickedAvatarPath   = ''.obs;
  final isSaving           = false.obs;

  final ageBands = const ['18 - 24', '25 - 34', '35 - 44', '45+'];

  @override
  void onClose() {
    fullNameController.dispose();
    searchLocationCtrl.dispose();
    super.onClose();
  }

  void onAgeBandSelected(String band) => selectedAgeBand.value = band;

  void onDateOfBirthTap(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 8, 12),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF6C63FF)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      dateOfBirth.value = '${picked.day} ${_month(picked.month)}, ${picked.year}';
    }
  }

  void onAvatarTap() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) pickedAvatarPath.value = picked.path;
  }

  void onSave() async {
    try {
      isSaving.value = true;
      await Future.delayed(const Duration(seconds: 1)); // TODO: API call
      Get.back();
    } catch (_) {
      // TODO: error snackbar
    } finally {
      isSaving.value = false;
    }
  }

  String _month(int m) => ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m];
}