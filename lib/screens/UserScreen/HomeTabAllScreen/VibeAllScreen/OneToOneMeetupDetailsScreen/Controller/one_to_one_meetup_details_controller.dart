import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/Widget/joined_one_to_one_sheet.dart';

import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../../ForYouAllScreen/PlanDetailsScreen/Widget/join_confirmation_sheet.dart';
// ---- Plan Detail Models ----
class LocationVoteItem {
  final String image;
  final String name;
  final int votes;
  final int totalVotes;
  final bool isSelected;

  const LocationVoteItem({
    required this.image,
    required this.name,
    required this.votes,
    required this.totalVotes,
    this.isSelected = false,
  });

  int get percent => ((votes / totalVotes) * 100).round();
}

class ChatMessage {
  final String senderName;
  final String message;
  final String time;
  final bool isMe;
  final String? avatar;

  const ChatMessage({
    required this.senderName,
    required this.message,
    required this.time,
    required this.isMe,
    this.avatar,
  });
}

class ReportReason {
  final String label;
  final RxBool isSelected;

  ReportReason({required this.label}) : isSelected = false.obs;
}

// ---- Plan Details Controller ----
class OneToOneMeetupDetailsController extends GetxController {
  // ---- Plan State ----
  final RxBool hasJoined = false.obs;
  // final hasJoined = false.obs;
  final attendanceConfirmed = false.obs;


  // ---- Location Votes ----
  final RxList<LocationVoteItem> locationVotes = <LocationVoteItem>[
    const LocationVoteItem(
      image: 'assets/images/location_img1.jpg',
      name: 'Hyde Park',
      votes: 3,
      totalVotes: 5,
      isSelected: true,
    ),
    const LocationVoteItem(
      image: 'assets/images/location_img2.jpg',
      name: 'Hempstead Heath',
      votes: 2,
      totalVotes: 5,
    ),
  ].obs;

  // ---- Chat Messages ----
  final RxList<ChatMessage> chatMessages = <ChatMessage>[
    const ChatMessage(
      senderName: 'Sarah L.',
      message: "Can't wait for the vinyl set! Is there a dress code? 🎵",
      time: '5:12 PM',
      isMe: false,
      avatar: 'assets/images/person1_img.jpg',
    ),
    const ChatMessage(
      senderName: 'Me',
      message: "I'm bringing a few rare records to show Marcus!",
      time: 'Just now',
      isMe: true,
    ),
  ].obs;

  // ---- Post-meetup Review ----
  final RxBool meetupHappened = true.obs;
  final RxInt selectedVibe = 2.obs;
  final List<String> vibes = ['Electric', 'Chill', 'Unreal', 'Awkward', 'Boring'];
  final List<String> vibeEmojis = ['⚡', '😌', '🔥', '🤡', '😴'];
  final reviewController = TextEditingController();


  // ---- Report ----
  final List<ReportReason> reportReasons = [
    ReportReason(label: 'Inappropriate behavior'),
    ReportReason(label: 'Harassment or bullying'),
    ReportReason(label: 'Spam or fake account'),
    ReportReason(label: 'Unsafe or suspicious activity'),
    ReportReason(label: 'Other'),
  ];
  final urgencyLevels = ['Low', 'Medium', 'High'];
  final selectedUrgency = 'High'.obs;

  // ---- Support ----
  final supportSubjectController = TextEditingController();
  final supportDescController = TextEditingController();

  // ======= Actions =======

  // Plan Detail
  void showJoinSheet() {
    Get.bottomSheet(
      const JoinedOneToOneSheet(),
      isScrollControlled: true,
    );
  }

  void onJoinConfirmed() {
    Get.back();
    hasJoined.value = true;
    AppSnackBar.success("Joined successfully");
  }

  void onConfirmAttendance() {
    attendanceConfirmed.value = true;
    Get.toNamed(AppRoutes.helpCenterScreen);
  }

  // Review
  void onSelectVibe(int index) => selectedVibe.value = index;
  void submitReview() => Get.toNamed(AppRoutes.helpCenterScreen);
  void planAgain() => Get.back();

  // Help Center Navigation
  void goToAttendanceTips() => Get.toNamed(AppRoutes.attendanceTipsScreen);
  void goToReportProblem() => Get.toNamed(AppRoutes.reportProblemScreen);
  void goToBlockUser() => Get.toNamed(AppRoutes.blockUserScreen);
  void goToSupportHelp() => Get.toNamed(AppRoutes.supportHelpScreen);

  // Report
  void selectReason(ReportReason reason) {
    for (final r in reportReasons) {
      r.isSelected.value = false;
    }
    reason.isSelected.value = true;
  }

  void submitReport() => Get.back();

  // Block
  void blockUser() => Get.back();

  // Support
  void submitSupport() => Get.back();



  @override
  void onClose() {
    reviewController.dispose();
    supportSubjectController.dispose();
    supportDescController.dispose();
    super.onClose();
  }
}