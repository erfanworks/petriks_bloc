import 'dart:ui';

import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';

class AvailabilityItem {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;
  const AvailabilityItem({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });
}

class WeeklyAvailabilityController extends GetxController {
  final selectedIndex = (-1).obs;

  final items = const [
    AvailabilityItem(
      emoji: '🌙',
      title: 'Weekday evenings',
      subtitle: 'Perfect for after-work hangouts and dinners.',
      bgColor: Color(0xFFEDE9FF),
    ),
    AvailabilityItem(
      emoji: '☀️',
      title: 'Weekend mornings',
      subtitle: 'Coffee, markets, and early adventures.',
      bgColor: Color(0xFFFFF3E0),
    ),
    AvailabilityItem(
      emoji: '♾️',
      title: 'Flexible',
      subtitle: "My schedule changes often. I'm open!",
      bgColor: Color(0xFFE0F7FA),
    ),
  ];

  void select(int i) => selectedIndex.value = i;

  void onSave() {
    if (selectedIndex.value == -1) {
      AppSnackBar.error('Please select availability');
      return;
    }
    AppSnackBar.success('Availability updated! ✅');
    // TODO: API call
  }
}