import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class FeelingModel {
  final String emoji;
  final String label;
  final double progress;
  final int count;

  const FeelingModel({
    required this.emoji,
    required this.label,
    required this.progress,
    required this.count,
  });
}

class JoinedUser {
  final String image;
  const JoinedUser({required this.image});
}

class FeedbackController extends GetxController {
  final planTitle    = 'Hang out at the park'.obs;
  final planLocation = 'Central Park West, NYC'.obs;
  final planDate     = 'Saturday, 24 June'.obs;
  final planVibe     = 'Chill Vibe'.obs;
  final planLanguage = 'English'.obs;
  final planType     = 'Group Plan'.obs;

  final overallVibe  = 'Good'.obs;
  final attended     = 4.obs;
  final positive     = '80%'.obs;

  final feelings = <FeelingModel>[
    const FeelingModel(emoji: '⚡', label: 'Electric', progress: 0.65, count: 2),
    const FeelingModel(emoji: '😊', label: 'Chill',    progress: 0.50, count: 2),
    const FeelingModel(emoji: '🔥', label: 'Unreal',   progress: 0.0,  count: 0),
    const FeelingModel(emoji: '🌿', label: 'Awkward',  progress: 0.0,  count: 0),
    const FeelingModel(emoji: '😴', label: 'Boring',   progress: 0.0,  count: 0),
  ];

  final joinedUsers = <JoinedUser>[
    const JoinedUser(image: 'assets/images/person1_img.jpg'),
    const JoinedUser(image: 'assets/images/onboarding5_img.jpg'),
    const JoinedUser(image: 'assets/images/onboarding2_img.jpg'),
    const JoinedUser(image: 'assets/images/onboarding4_img.jpg'),
  ];

  void onCreateAgain() => Get.toNamed(AppRoutes.createPlanScreen);
}