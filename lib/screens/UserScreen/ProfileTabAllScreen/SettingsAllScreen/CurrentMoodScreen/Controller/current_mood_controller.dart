import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';

class MoodItem {
  final String emoji;
  final String title;
  const MoodItem({required this.emoji, required this.title});
}

class CurrentMoodController extends GetxController {
  final selectedIndex = (-1).obs;

  final items = const [
    MoodItem(emoji: '🏠', title: 'Get out of the house'),
    MoodItem(emoji: '💬', title: 'Talk to someone'),
    MoodItem(emoji: '🙏', title: 'Do something calm'),
    MoodItem(emoji: '⚡', title: 'Do something active'),
    MoodItem(emoji: '😄', title: 'Laugh more'),
    MoodItem(emoji: '✨', title: 'Try something new'),
    MoodItem(emoji: '🌍', title: 'Meet people in my language'),
  ];

  void select(int i) => selectedIndex.value = i;

  void onSave() {
    if (selectedIndex.value == -1) {
      AppSnackBar.error('Please select a mood');
      return;
    }
    AppSnackBar.success('Mood updated! ✅');
    // TODO: API call
  }
}