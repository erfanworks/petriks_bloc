import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/BlockService/block_service.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../Widget/AppDialog/app_confirm_dialog.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

class ChatItem {
  final String id, name, lastMsg, time, avatar;
  final int unread;
  final bool isOnline;

  const ChatItem({
    required this.id,
    required this.name,
    required this.lastMsg,
    required this.time,
    required this.avatar,
    this.unread = 0,
    this.isOnline = true,
  });
}

class ChatMessage {
  final String id, senderId, senderName, text, time;
  final bool isMe;
  final bool isHost;
  final bool isSystemMsg;
  final List<String>? mediaPaths;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.time,
    this.isMe = false,
    this.isHost = false,
    this.isSystemMsg = false,
    this.mediaPaths,
  });
}

class ChatController extends GetxController {
  final selectedTab = 0.obs;
  final tabs = ['Direct', 'Plan', 'Group'];
  final ImagePicker _picker = ImagePicker();
  final RxString selectedChatImagePath = ''.obs;
  final RxList<String> selectedMediaPaths = <String>[].obs;
  final messageController = TextEditingController();

  final List<ChatItem> chats = [
    const ChatItem(id: '1', name: 'Midnight Jazz Session',
        lastMsg: 'Are we still meeting at the ...', time: '2:45 PM',
        avatar: 'assets/images/onboarding1_img.jpg', unread: 2),
    const ChatItem(id: '2', name: 'Weekend Food Tour',
        lastMsg: 'That sounds like a great plan!', time: '1:12 PM',
        avatar: 'assets/images/onboarding2_img.jpg'),
    const ChatItem(id: '3', name: 'Weekend Food Tour',
        lastMsg: 'That sounds like a great plan!', time: '1:12 PM',
        avatar: 'assets/images/onboarding3_img.jpg'),
    const ChatItem(id: '4', name: 'Weekend Food Tour',
        lastMsg: 'That sounds like a great plan!', time: '1:12 PM',
        avatar: 'assets/images/onboarding4_img.jpg'),
    const ChatItem(id: '5', name: 'Midnight Jazz Session',
        lastMsg: 'Are we still meeting at the ...', time: '2:45 PM',
        avatar: 'assets/images/auth_img.jpg', unread: 2),
    const ChatItem(id: '6', name: 'Weekend Food Tour',
        lastMsg: 'That sounds like a great plan!', time: '1:12 PM',
        avatar: 'assets/images/onboarding5_img.jpg'),
  ].obs;

  final List<ChatMessage> messages = [
    const ChatMessage(id: '1', senderId: 'sarah', senderName: 'Sarah',
        text: "Hey everyone! So excited for this brunch. I've been to this cafe before and their coffee is amazing! ☕",
        time: '10:05 AM', isHost: true),
    const ChatMessage(id: '2', senderId: 'mike', senderName: 'Mike',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: '3', senderId: 'emma', senderName: 'Emma',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: 's1', senderId: 'system', senderName: '',
        text: 'You joined this plan', time: '', isSystemMsg: true),
    const ChatMessage(id: '4', senderId: 'sarah', senderName: 'Sarah',
        text: "Hey everyone! So excited for this brunch. I've been to this cafe before and their coffee is amazing! ☕",
        time: '10:05 AM', isHost: true),
  ].obs;

  final List<ChatMessage> directMessages = [
    const ChatMessage(id: '1', senderId: 'mike', senderName: 'Mike',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: '2', senderId: 'me', senderName: 'Me',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM', isMe: true),
    const ChatMessage(id: '3', senderId: 'mike', senderName: 'Mike',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: '4', senderId: 'me', senderName: 'Me',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM', isMe: true),
    const ChatMessage(id: '5', senderId: 'mike', senderName: 'Mike',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: '6', senderId: 'me', senderName: 'Me',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM', isMe: true),
    const ChatMessage(id: '7', senderId: 'mike', senderName: 'Mike',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM'),
    const ChatMessage(id: '8', senderId: 'me', senderName: 'Me',
        text: 'Looking forward to it! How will we recognize each other?',
        time: '10:05 AM', isMe: true),
  ].obs;

  final List<ChatMessage> planMessages = [
    const ChatMessage(
      id: 's1', senderId: 'system', senderName: '',
      text: 'You joined this plan', time: '', isSystemMsg: true,
    ),
    const ChatMessage(
      id: '1', senderId: 'sarah', senderName: 'Sarah',
      text: "Hey everyone! So excited for this brunch. I've been to this cafe before and their coffee is amazing! ☕",
      time: '10:05 AM', isHost: true,
    ),
    const ChatMessage(
      id: '2', senderId: 'mike', senderName: 'Mike',
      text: 'Looking forward to it! How will we recognize each other?',
      time: '10:05 AM',
    ),
    const ChatMessage(
      id: '3', senderId: 'emma', senderName: 'Emma',
      text: 'Looking forward to it! How will we recognize each other?',
      time: '10:05 AM',
    ),
    const ChatMessage(
      id: 's2', senderId: 'system', senderName: '',
      text: 'You joined this plan', time: '', isSystemMsg: true,
    ),
    const ChatMessage(
      id: '4', senderId: 'sarah', senderName: 'Sarah',
      text: "Hey everyone! So excited for this brunch. I've been to this cafe before and their coffee is amazing! ☕",
      time: '10:05 AM', isHost: true,
    ),
  ].obs;

  void sendGroupMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedMediaPaths.isEmpty) return;

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'Me',
      text: text,
      time: '$hour:$minute $period',
      isMe: true,
      mediaPaths: List.from(selectedMediaPaths),
    ));

    messageController.clear();
    selectedMediaPaths.clear();
  }

  void sendPlanMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedMediaPaths.isEmpty) return;

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    planMessages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'Me',
      text: text,
      time: '$hour:$minute $period',
      isMe: true,
      mediaPaths: List.from(selectedMediaPaths),
    ));

    messageController.clear();
    selectedMediaPaths.clear();
  }


  void pickChatImage() {
    MediaPickerBottomSheet.show(
      onCamera: () async {
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          selectedMediaPaths.add(photo.path);
        }
      },
      onGallery: () async {
        final List<XFile> photos = await _picker.pickMultiImage();
        if (photos.isNotEmpty) {
          selectedMediaPaths.addAll(photos.map((e) => e.path));
        }
      },
    );
  }

  void sendDirectMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty && selectedMediaPaths.isEmpty) return;

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    directMessages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: 'Me',
      text: text,
      mediaPaths: List.from(selectedMediaPaths),
      time: '$hour:$minute $period',
      isMe: true,
    ));

    messageController.clear();
    selectedMediaPaths.clear();
  }

  // TODO(API): community-র competition আছে কিনা API থেকে আসবে
  final RxBool hasCompetition = true.obs;

  void confirmLeaveCommunityChat() {
    AppConfirmDialog.show(
      title: 'Leave Community Chat?',
      message:
          'Are you sure you want to leave this community chat? You will stop receiving its messages.',
      confirmText: 'Leave Chat',
      icon: Icons.logout_rounded,
      onConfirm: () {
        Get.back(); // chat screen বন্ধ
        AppSnackBar.message('You have left the community chat');
      },
    );
  }

  void confirmLeavePlan() {
    AppConfirmDialog.show(
      title: 'Leave Plan?',
      message:
          'Are you sure you want to leave this plan? You will also be removed from its chat.',
      confirmText: 'Leave Plan',
      icon: Icons.logout_rounded,
      onConfirm: () {
        Get.back(); // plan chat screen বন্ধ
        AppSnackBar.message('You have left the plan');
      },
    );
  }

  // Direct tab-এ blocked ইউজারের চ্যাট লুকানো হয়
  List<ChatItem> get visibleChats {
    if (selectedTab.value != 0) return chats;
    return chats
        .where((chat) => !BlockService.to.isBlocked(chat.name))
        .toList();
  }

  void switchTab(int i) => selectedTab.value = i;

  void openChat(ChatItem item) {
    if (selectedTab.value == 0) {
      Get.toNamed(AppRoutes.directChatScreen, arguments: item);
    } else if (selectedTab.value == 1) {
      Get.toNamed(AppRoutes.planChatScreen, arguments: item);
    } else {
      Get.toNamed(AppRoutes.groupPlanChatScreen, arguments: item);
    }
  }
  @override
  void onClose() {
    // messageController.dispose();
    super.onClose();
  }
}