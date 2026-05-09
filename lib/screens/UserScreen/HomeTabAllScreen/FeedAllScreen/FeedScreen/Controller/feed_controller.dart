import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

// ─── Feed Post Model ──────────────────────────────────────────────────────────
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

// ─── Comment Model ────────────────────────────────────────────────────────────
class CommentModel {
  final String userImage;
  final String userName;
  final String timeAgo;
  final String content;
  final int likes;
  final CommentModel? reply;

  const CommentModel({
    required this.userImage,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.likes,
    this.reply,
  });
}

// ─── Feed Controller ──────────────────────────────────────────────────────────
class FeedController extends GetxController {
  // ── Create Post ──
  final postController  = ''.obs;
  final pickedImagePath = ''.obs;
  final isPostLoading   = false.obs;

  // ── Comment Screen ──
  final commentInput      = ''.obs;
  final isLiked           = false.obs;
  final likeCount         = 0.obs;
  final isSendingComment  = false.obs;

  // ── Comments List ──
  final comments = <CommentModel>[
    const CommentModel(
      userImage: 'assets/images/onboarding2_img.jpg',
      userName: 'Elena Vance',
      timeAgo: '12m',
      content: "I'm just around the corner! Their Ethiopian pour-over is legendary. See you in 5?",
      likes: 14,
      reply: CommentModel(
        userImage: 'assets/images/person1_img.jpg',
        userName: 'Marcus Thorne',
        timeAgo: '8m',
        content: 'Wait for me too! Just finishing up a meeting at the co-working space.',
        likes: 3,
      ),
    ),
    const CommentModel(
      userImage: 'assets/images/hank_out_party_img.jpg',
      userName: 'Elena Vance',
      timeAgo: '12m',
      content: "I'm just around the corner! Their Ethiopian pour-over is legendary. See you in 5?",
      likes: 14,
    ),
    const CommentModel(
      userImage: 'assets/images/onboarding2_img.jpg',
      userName: 'Elena Vance',
      timeAgo: '12m',
      content: "I'm just around the corner! Their Ethiopian pour-over is legendary. See you in 5?",
      likes: 14,
    ),
    const CommentModel(
      userImage: 'assets/images/person1_img.jpg',
      userName: 'Elena Vance',
      timeAgo: '12m',
      content: "I'm just around the corner! Their Ethiopian pour-over is legendary. See you in 5?",
      likes: 14,
    ),
  ].obs;

  // ── Feed Posts ──
  final List<FeedPost> posts = [
    const FeedPost(
      userImage: 'assets/images/onboarding2_img.jpg',
      userName: 'Marcus Chen',
      timeAgo: '2h ago',
      postImage: 'assets/images/hank_out_party_img.jpg',
      locationTag: 'North Meadow, Central Park',
      content: 'Great coffee and even better conversation at Mohandis today! Sometimes all you need is a change of scenery and good company to spark new ideas.',
      likes: 12,
      comments: 4,
      likedByText: 'Liked by John and 12 others',
    ),
    const FeedPost(
      userImage: 'assets/images/person1_img.jpg',
      userName: 'Marcus Chen',
      timeAgo: '2h ago',
      postImage: 'assets/images/hank_out_park_party_img.jpg',
      locationTag: 'North Meadow, Central Park',
      content: 'Great coffee and even better conversation at Mohandis today! Sometimes all you need is a change of scenery and good company to spark new ideas.',
      likes: 12,
      comments: 4,
      likedByText: 'Liked by Jhon and 12 others',
    ),
  ];


  void onLike(FeedPost post) {
    isLiked.value  = !isLiked.value;
    likeCount.value = isLiked.value ? post.likes + 1 : post.likes;
  }

  void onCreatePost() => Get.toNamed(AppRoutes.createPostScreen);
  void onComment(FeedPost post) => Get.toNamed(AppRoutes.commentScreen, arguments: post);

  void onMore(FeedPost post) {
    Get.bottomSheet(
      _MoreOptionsSheet(),
      backgroundColor: Get.theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
    );
  }


  void onPostPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) pickedImagePath.value = picked.path;
  }

  void onPickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) pickedImagePath.value = picked.path;
  }

  void onTagFriends() => Get.toNamed('/tag-friends');

  void onFeeling() => Get.toNamed('/feeling');

  void onSubmitPost() async {
    Get.back();
    if (postController.value.trim().isEmpty && pickedImagePath.value.isEmpty) return;
    try {
      isPostLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      postController.value  = '';
      pickedImagePath.value = '';
      Get.back();
    } catch (_) {
    } finally {
      isPostLoading.value = false;
    }
  }


  void onCommentChanged(String value) => commentInput.value = value;

  void onSendComment() async {
    if (commentInput.value.trim().isEmpty) return;
    try {
      isSendingComment.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      comments.insert(
        0,
        CommentModel(
          userImage: 'assets/images/onboarding2_img.jpg',
          userName: 'You',
          timeAgo: 'just now',
          content: commentInput.value.trim(),
          likes: 0,
        ),
      );
      commentInput.value = '';
    } catch (_) {
      // TODO
    } finally {
      isSendingComment.value = false;
    }
  }

  void onLikeComment(int index) {
    // TODO: API call + local toggle
  }

  void onReplyComment(int index) {
    // TODO
  }
}

class _MoreOptionsSheet extends StatelessWidget {
  const _MoreOptionsSheet();

  @override
  Widget build(BuildContext context) {
    // TODO
    return Card(color: ConstColor.primaryColor,);
  }
}