import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:petriks_flutter_app/Widget/BlockService/block_service.dart';
export 'package:petriks_flutter_app/Widget/BlockService/block_service.dart'
    show BlockedUserModel;

// Block User Controller
class BlockUserListController extends GetxController {
  final blockedUsers = BlockService.to.blockedUsers;

  void onUnblockTap(BlockedUserModel user) {
    Get.bottomSheet(
      UnblockSheet(user: user, controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onConfirmUnblock(BlockedUserModel user) {
    Get.back();
    blockedUsers.remove(user);
    // TODO: API call
  }
}

// Unblock Sheet Widget
class UnblockSheet extends StatelessWidget {
  final BlockedUserModel user;
  final BlockUserListController controller;
  const UnblockSheet({super.key, required this.user, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(color: const Color(0xFFE4E5EB), borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: Get.back,
              child: const Icon(Icons.close, size: 20, color: Color(0xFF191C1E)),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(user.image, width: 64, height: 64, fit: BoxFit.cover),
          ),
          const SizedBox(height: 14),
          Text(
            'Unblock ${user.name.split(' ').first}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191C1E), fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 6),
          const Text(
            'They will be able to message you and see your profile updates again',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFF999999), fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: Get.back,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE4E5EB)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF191C1E), fontFamily: 'Roboto')),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onConfirmUnblock(user),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('Unblock', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Roboto')),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
        ],
      ),
    );
  }
}
