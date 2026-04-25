import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

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

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.time,
    this.isMe = false,
    this.isHost = false,
    this.isSystemMsg = false,
  });
}

class ChatController extends GetxController {
  final selectedTab = 0.obs;
  final tabs = ['Direct', 'Plan', 'Group'];

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
  ];

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
  ];

  void switchTab(int i) => selectedTab.value = i;

  void openChat(ChatItem item) {
    if (selectedTab.value == 0) {
      Get.toNamed(AppRoutes.directChatScreen, arguments: item);
    } else {
      Get.toNamed(AppRoutes.groupPlanChatScreen, arguments: item);
    }
  }
}