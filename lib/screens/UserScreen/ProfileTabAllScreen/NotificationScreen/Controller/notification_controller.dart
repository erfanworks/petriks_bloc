import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NotificationItem {
  final String name, message, planName, planEmoji, time, image;
  const NotificationItem({
    required this.name,
    required this.message,
    required this.planName,
    required this.planEmoji,
    required this.time,
    required this.image,
  });
}

class NotificationController extends GetxController {
  final recentActivity = <NotificationItem>[
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/person1_img.jpg',
    ),
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/onboarding5_img.jpg',
    ),
  ];

  final yesterday = <NotificationItem>[
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/onboarding2_img.jpg',
    ),
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/onboarding3_img.jpg',
    ),
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/onboarding1_img.jpg',
    ),
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/onboarding4_img.jpg',
    ),
    const NotificationItem(
      name: 'Marcus Chen', message: 'invited you to join',
      planName: 'Nature Walk', planEmoji: '🌿',
      time: '2m ago', image: 'assets/images/fitness_img.jpg',
    ),
  ];
}