import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/AppDialog/app_confirm_dialog.dart';
import 'package:petriks_flutter_app/Widget/BlockService/block_service.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class HostProfileController extends GetxController {
  final selectedReason = ''.obs;
  final selectedUrgency = 'High'.obs;
  final isReportSubmitted = false.obs;
  final otherReasonController = TextEditingController();

  String get finalReason => selectedReason.value == 'Other'
      ? otherReasonController.text.trim()
      : selectedReason.value;

  String get _userName => name.split(',').first.trim();
  bool get isBlocked => BlockService.to.isBlocked(_userName);

  final List<String> reportReasons = [
    'Inappropriate behaviour',
    'Harassment or bullying',
    'Spam or fake account',
    'Unsafe or suspicious activity',
    'Other',
  ];

  final List<String> urgencyLevels = ['Low', 'Medium', 'High'];

  final name = 'Oliver, 26';
  final location = 'London';
  final languages = 'English, French';
  final bio =
      'Passionate about exploring local culture and finding the best street food in London. Always up for a friendly cricket match or a tech talk!';
  final followers = '24 Followers';
  final following = '18 Following';
  final mutualCount = '2 mutual connections you both know';
  final isVerified = true;
  final isFollowing = false.obs;

  final List<Map<String, String>> aboutStats = [
    {'label': 'Preference', 'value': '1:1', 'icon': 'assets/icons/both_person_icon.svg'},
    {'label': 'Energy', 'value': 'Social', 'icon': 'assets/icons/energy_icon.svg'},
    {'label': 'Travel', 'value': 'Flexible', 'icon': 'assets/icons/watch_icon.svg'},
  ];

  final List<Map<String, String>> interests = [
    {'label': 'Coffee & Brunch', 'icon': 'assets/icons/cofee_cup_icon.svg'},
    {'label': 'Hiking & Outdoors', 'icon': 'assets/icons/hiking_outdoors_icon.svg'},
    {'label': 'Art & Museums', 'icon': 'assets/icons/art_icon.svg'},
    {'label': 'Travel', 'icon': 'assets/icons/travel_icon.svg'},
    {'label': 'Cooking', 'icon': 'assets/icons/cooking_icon.svg'},
    {'label': 'Photography', 'icon': 'assets/icons/camera_icon.svg'},
    {'label': 'Live Music', 'icon': 'assets/icons/music_icon.svg'},
  ];

  final List<Map<String, String>> badges = [
    {'label': 'On-time host', 'sub': '12 Plans', 'icon': 'assets/icons/watch_icon.svg'},
    {'label': 'Inclusive host', 'sub': 'All Welcome', 'icon': 'assets/icons/profile_icon.svg'},
    {'label': 'Quick reply', 'sub': 'Under 2 HR', 'icon': 'assets/icons/energy_icon.svg'},
  ];

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

  final List<Map<String, String>> plans = [
    {
      'title': 'Weekend Coding Retreat',
      'location': 'Shoreditch Innovation Lab',
      'date': 'Saturday, 10:00 AM',
      'tag': 'HOSTED',
    },
    {
      'title': 'Weekend Coding Retreat',
      'location': 'Shoreditch Innovation Lab',
      'date': 'Saturday, 10:00 AM',
      'tag': 'HOSTED',
    },
  ];

  final List<Map<String, String>> communities = [
    {'name': 'Urban Athletes', 'sub': '12 Group', 'image': 'assets/images/hank_out_park_party_img.jpg'},
    {'name': 'Urban Athletes', 'sub': '12 Group', 'image': 'assets/images/hank_out_party_img.jpg'},
  ];

  bool _guardBlocked() {
    if (!isBlocked) return false;
    AppSnackBar.message('Unblock $_userName to continue');
    return true;
  }

  void toggleFollow() {
    if (_guardBlocked()) return;
    isFollowing.value = !isFollowing.value;
  }

  void onMessage() {
    if (_guardBlocked()) return;
    Get.toNamed(AppRoutes.directChatScreen);
  }

  void onBlockTap() {
    if (isBlocked) {
      AppConfirmDialog.show(
        title: 'Unblock $_userName?',
        message: 'They will be able to message you and see your profile again.',
        confirmText: 'Unblock',
        icon: Icons.lock_open_rounded,
        isDestructive: false,
        onConfirm: () {
          BlockService.to.unblock(_userName);
          AppSnackBar.success('$_userName unblocked');
        },
      );
      return;
    }
    AppConfirmDialog.show(
      title: 'Block $_userName?',
      message:
          "They won't be able to message you or see your profile, and you won't see theirs. You can unblock them later.",
      confirmText: 'Block',
      icon: Icons.block_rounded,
      onConfirm: () {
        BlockService.to.block(
          name: _userName,
          image: 'assets/images/onboarding2_img.jpg',
        );
        Get.back(); // প্রোফাইল বন্ধ
        AppSnackBar.success('$_userName blocked');
      },
    );
  }

  void selectReason(String reason) {
    selectedReason.value = reason;
    if (reason != 'Other') otherReasonController.clear();
  }

  void selectUrgency(String level) => selectedUrgency.value = level;

  void submitReport() {
    if (selectedReason.value.isEmpty) return;
    if (selectedReason.value == 'Other' &&
        otherReasonController.text.trim().isEmpty) {
      AppSnackBar.error("Please tell us your reason");
      return;
    }
    isReportSubmitted.value = true;
  }

  void resetReport() {
    selectedReason.value = '';
    selectedUrgency.value = 'High';
    isReportSubmitted.value = false;
    otherReasonController.clear();
  }

  @override
  void onClose() {
    otherReasonController.dispose();
    super.onClose();
  }
}
