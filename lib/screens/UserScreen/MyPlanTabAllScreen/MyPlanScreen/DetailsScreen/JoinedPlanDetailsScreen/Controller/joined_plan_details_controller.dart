import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../../BaseScreen/NavBar/controller/navbar_controller.dart';
import '../../../../../HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Widget/join_confirmation_sheet.dart';
import '../Widget/joined_plan_confirmation_sheet.dart';

// ---- Plan Detail Models ----
class JoinedLocationVoteItem {
  final String image;
  final String name;
  final int votes;
  final int totalVotes;
  final bool isSelected;

  const JoinedLocationVoteItem({
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

  bool get isOther => label == 'Other';
}

// ---- Plan Details Controller ----
class JoinedPlanDetailsController extends GetxController {
  // ---- Plan State ----
  final RxBool hasJoined = false.obs;
  final RxInt selectedTimeIndex = 0.obs;

  // ---- Lock Timer ----
  final lockTimer = ''.obs;
  Timer? _timer;

  // lockUntil is set from plan data (passed via Get.arguments or API)
  DateTime? lockUntil;
  final RxBool isReportSelected = false.obs;
  final attendanceConfirmed = false.obs;
  bool get isTimerExpired => lockTimer.value.isEmpty && lockUntil != null;


  void initLockTimer(DateTime lockUntilTime) {
    lockUntil = lockUntilTime;
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _tick(); // run immediately once before first delay
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (lockUntil == null) return;

    final remaining = lockUntil!.difference(DateTime.now());

    if (remaining.isNegative || remaining.inSeconds == 0) {
      _timer?.cancel();
      lockTimer.value = '';
      return;
    }

    final h = remaining.inHours;
    final m = remaining.inMinutes % 60;
    final s = remaining.inSeconds % 60;

    lockTimer.value = h > 0
        ? '${h}h ${m.toString().padLeft(2, '0')}m'
        : '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  // ---- Location Votes ----
  final RxList<JoinedLocationVoteItem> locationVotes = <JoinedLocationVoteItem>[
    const JoinedLocationVoteItem(
      image: 'assets/images/location_img1.jpg',
      name: 'Hyde Park',
      votes: 3,
      totalVotes: 5,
      isSelected: true,
    ),
    const JoinedLocationVoteItem(
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
  final List<String> vibes = [
    'Electric',
    'Chill',
    'Unreal',
    'Awkward',
    'Boring',
  ];
  final List<String> vibeEmojis = ['⚡', '😌', '🔥', '🤡', '😴'];
  final reviewController = TextEditingController();

  // ---- Couldn't Attend Reasons ----
  final List<ReportReason> reportReasons = [
    ReportReason(label: 'Sick / Feeling unwell'),
    ReportReason(label: 'Family emergency'),
    ReportReason(label: 'Schedule conflict'),
    ReportReason(label: 'Transport issues'),
    ReportReason(label: 'Other'),
  ];
  final otherReasonController = TextEditingController();
  final RxBool isOtherSelected = false.obs;

  String get finalReason {
    final selected = reportReasons.firstWhereOrNull((r) => r.isSelected.value);
    if (selected == null) return '';
    return selected.isOther ? otherReasonController.text.trim() : selected.label;
  }
  final urgencyLevels = ['Low', 'Medium', 'High'];
  final selectedUrgency = 'High'.obs;

  // ---- Support ----
  final supportSubjectController = TextEditingController();
  final supportDescController = TextEditingController();

  // ======= Actions =======

  void showJoinSheet() {
    Get.bottomSheet(
      const JoinedPlanConfirmationSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void confirmJoined() {
    hasJoined.value = true;
    Get.back();
    AppSnackBar.success("Joined successfully 🎉", seconds: 2);
    Get.find<NavbarController>().highlightMyPlan();
  }

  void onConfirmAttendance() {
    attendanceConfirmed.value = true;
    Get.toNamed(AppRoutes.helpCenterScreen);
    AppSnackBar.success("Attendance successfully 🎉", seconds: 2);
  }

  void onSelectVibe(int index) => selectedVibe.value = index;

  void submitReview() => Get.toNamed(AppRoutes.navBar);

  void planAgain() => Get.back();

  void goToAttendanceTips() => Get.toNamed(AppRoutes.attendanceTipsScreen);

  void goToReportProblem() => Get.toNamed(AppRoutes.reportProblemScreen);

  void goToBlockUser() => Get.toNamed(AppRoutes.blockUserScreen);

  void goToSupportHelp() => Get.toNamed(AppRoutes.supportHelpScreen);

  void selectReason(ReportReason reason) {
    for (final r in reportReasons) {
      r.isSelected.value = false;
    }

    reason.isSelected.value = true;
    isOtherSelected.value = reason.isOther;
    if (!reason.isOther) otherReasonController.clear();

    isReportSelected.value = true;
  }

  void selectTime(int index) => selectedTimeIndex.value = index;

  void submitReport() {

    final bool hasSelected = reportReasons.any(
          (reason) => reason.isSelected.value,
    );

    if (!hasSelected) {
      AppSnackBar.error("Please select a report reason");
      return;
    }

    if (isOtherSelected.value && otherReasonController.text.trim().isEmpty) {
      AppSnackBar.error("Please tell us your reason");
      return;
    }

    Get.toNamed(AppRoutes.navBar);

    Future.delayed(const Duration(milliseconds: 100), () {
      AppSnackBar.success("Report submitted successfully");
    });
  }

  void blockUser() {
    Get.back();
    AppSnackBar.success("User blocked successfully 🚫");
  }

  void submitSupport() {
    Get.back();
    AppSnackBar.success("Support request sent successfully! ✅");
  }

  @override
  void onClose() {
    reviewController.dispose();
    supportSubjectController.dispose();
    supportDescController.dispose();
    otherReasonController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  @override
  @override
  void onInit() {
    super.onInit();
    initLockTimer(DateTime.now().add(const Duration(minutes: 10)));
  }
}
