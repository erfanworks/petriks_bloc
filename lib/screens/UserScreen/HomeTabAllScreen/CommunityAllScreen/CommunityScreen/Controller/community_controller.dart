import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

// ---- Models ----
class CommunityItem {
  final String image;
  final String tag;
  final String title;
  final String description;
  final String memberCount;

  const CommunityItem({
    required this.image,
    required this.tag,
    required this.title,
    required this.description,
    required this.memberCount,
  });
}

class AppNewsItem {
  final String emoji;
  final String title;
  final String description;
  final String timeAgo;

  const AppNewsItem({
    required this.emoji,
    required this.title,
    required this.description,
    required this.timeAgo,
  });
}

// ---- Community Controller ----
class CommunityController extends GetxController {
  // ---- Sub Tabs ----
  final communityTabs = ['Discover', 'My Community'];
  final selectedCommunityTab = 0.obs;

  // ---- Communities ----
  final List<CommunityItem> communities = [
    const CommunityItem(
      image: 'assets/images/fitness_img.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      description: 'High-intensity street workouts and community-led track sessions in the heart of the city.',
      memberCount: '1.2k',
    ),
    const CommunityItem(
      image: 'assets/images/fotball_img.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      description: 'High-intensity street workouts and community-led track sessions in the heart of the city.',
      memberCount: '1.2k',
    ),
    const CommunityItem(
      image: 'assets/images/fitness_img.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      description: 'High-intensity street workouts and community-led track sessions in the heart of the city.',
      memberCount: '1.2k',
    ),
  ];

  // ---- App News ----
  final List<AppNewsItem> appNews = [
    const AppNewsItem(
      emoji: '⭐',
      title: 'Pro Curators Badge Launched',
      description: 'Top community leaders can now earn verified badges for high engagement.',
      timeAgo: '2h ago',
    ),
    const AppNewsItem(
      emoji: '🎁',
      title: '1 Million Members!',
      description: "We've reached a huge milestone thanks to you. Special gifts in your inbox.",
      timeAgo: '5h ago',
    ),
  ];

  // ---- Actions ----
  void onViewCommunity(CommunityItem item) => Get.toNamed(AppRoutes.communityDetailScreen);
}