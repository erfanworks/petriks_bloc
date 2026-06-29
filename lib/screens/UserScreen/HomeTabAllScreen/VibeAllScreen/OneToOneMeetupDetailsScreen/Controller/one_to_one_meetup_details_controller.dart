import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/Widget/joined_one_to_one_sheet.dart';
import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../widget/SelectPackageSheet/select_package_sheet.dart';
import '../../../../../BaseScreen/NavBar/controller/navbar_controller.dart';


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
  LocationVoteItem copyWith({bool? isSelected}) {
    return LocationVoteItem(
      image: image,
      name: name,
      votes: votes,
      totalVotes: totalVotes,
      isSelected: isSelected ?? this.isSelected,
    );
  }
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
  final RxBool hasJoined = false.obs;
  final RxBool showBoostGate = true.obs;
  final RxInt selectedTimeIndex = (-1).obs;
  final lockTimer = ''.obs;
  Timer? _timer;
  final attendanceConfirmed = false.obs;
  bool get isTimerExpired => lockTimer.value.isEmpty && lockUntil != null;
  bool get isLocked => lockTimer.value.isEmpty && lockUntil != null;
  final hasNavigated = false.obs;

  DateTime? lockUntil;

  void initLockTimer(DateTime lockUntilTime) {
    lockUntil = lockUntilTime;
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void selectLocation(LocationVoteItem selected) {
    for (int i = 0; i < locationVotes.length; i++) {
      locationVotes[i] = locationVotes[i].copyWith(
        isSelected: locationVotes[i] == selected,
      );
    }
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
  final RxList<LocationVoteItem> locationVotes = <LocationVoteItem>[
    const LocationVoteItem(
      image: 'assets/images/location_img1.jpg',
      name: 'Hyde Park',
      votes: 3,
      totalVotes: 5,
      isSelected: false,
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

  void selectTime(int index) => selectedTimeIndex.value = index;

  // Plan Detail
  void showSelectPackageSheet() {
    Get.bottomSheet(
      SelectPackageSheet(
        onConfirm: () {
          Get.back();
          showBoostGate.value = false;
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void showJoinSheet() {
    Get.bottomSheet(
      const JoinedOneToOneSheet(),
      isScrollControlled: true,
    );
  }

  void onJoinConfirmed() {
    Navigator.of(Get.context!).pop();
    hasJoined.value = true;
    AppSnackBar.success("Joined successfully");

    Get.find<NavbarController>().highlightMyPlan();
  }

  void onConfirmAttendance() {
    attendanceConfirmed.value = true;
    Get.toNamed(AppRoutes.helpCenterScreen);
    AppSnackBar.success("Attendance successfully 🎉", seconds: 2);
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
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // initLockTimer(DateTime.now().add(const Duration(hours: 2, minutes: 30)));
    initLockTimer(DateTime.now().add(const Duration(seconds: 35)));
  }
}