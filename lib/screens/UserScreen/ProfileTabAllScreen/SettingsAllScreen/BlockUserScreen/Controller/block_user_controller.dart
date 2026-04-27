import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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

class BlockUserListController extends GetxController {
  final blockedUsers = <BlockedUserModel>[
    const BlockedUserModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez',  blockedSince: 'Oct 12, 2023'),
    const BlockedUserModel(image: 'assets/images/person2_img.jpg', name: 'Marcus Sterling',  blockedSince: 'Sep 04, 2023'),
    const BlockedUserModel(image: 'assets/images/person3_img.jpg', name: 'Sarah Jenkins',    blockedSince: 'Aug 21, 2023'),
    const BlockedUserModel(image: 'assets/images/person4_img.jpg', name: 'David Chen',       blockedSince: 'Jul 15, 2023'),
  ].obs;

  void onUnblockTap(BlockedUserModel user) {
    // Get.bottomSheet(UnblockSheet(user: user, controller: this), ...);
  }

  void onConfirmUnblock(BlockedUserModel user) async {
    Get.back();
    blockedUsers.remove(user);
    // TODO: API call to unblock user
  }
}

class _UnblockSheet extends StatelessWidget {
  final BlockedUserModel user;
  final BlockUserListController controller;
  const _UnblockSheet({required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // replaced by full UI in block_user_screen.dart
  }
}