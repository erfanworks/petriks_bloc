import 'package:get/get.dart';

// ---- Feed Post Model ----
class FeedPost {
  final String userImage;
  final String userName;
  final String timeAgo;
  final String? postImage;
  final String? locationTag;
  final String content;
  final int likes;
  final int comments;
  final String likedByText;

  const FeedPost({
    required this.userImage,
    required this.userName,
    required this.timeAgo,
    this.postImage,
    this.locationTag,
    required this.content,
    required this.likes,
    required this.comments,
    required this.likedByText,
  });
}

class FeedController extends GetxController {
  final postController = RxString('');

  final List<FeedPost> posts = [
    const FeedPost(
      userImage: 'assets/images/onboarding2_img.jpg',
      userName: 'Marcus Chen',
      timeAgo: '2h ago',
      postImage: 'assets/images/hank_out_party_img.jpg',
      locationTag: 'North Meadow, Central Park',
      content: 'Great coffee and even better conversation at Dhanmondi today! ☕ Sometimes all you need is a change of scenery and good company to spark new ideas.',
      likes: 12,
      comments: 4,
      likedByText: 'Liked by Jhon and 12 others',
    ),
    const FeedPost(
      userImage: 'assets/images/person1_img.jpg',
      userName: 'Marcus Chen',
      timeAgo: '2h ago',
      postImage: 'assets/images/hank_out_park_party_img.jpg',
      locationTag: 'North Meadow, Central Park',
      content: 'Great coffee and even better conversation at Dhanmondi today! ☕ Sometimes all you need is a change of scenery and good company to spark new ideas.',
      likes: 12,
      comments: 4,
      likedByText: 'Liked by Jhon and 12 others',
    ),
  ];

  void onLike(FeedPost post) {}
  void onComment(FeedPost post) {}
  void onMore(FeedPost post) {}
  void onPostPhoto() {}
  void onTagFriends() {}
  void onFeeling() {}
}