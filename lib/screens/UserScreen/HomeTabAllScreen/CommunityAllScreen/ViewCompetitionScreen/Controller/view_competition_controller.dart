import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/constant/const_string.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppDialog/app_dialog.dart';

////// Models
class RosterGroup {
  final String image;
  final String name;
  final String memberCount;
  final List<String> avatars;
  final int extraCount;

  const RosterGroup({
    required this.image,
    required this.name,
    required this.memberCount,
    required this.avatars,
    required this.extraCount,
  });
}

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

///// Controller
class ViewCompetitionController extends GetxController {
  ///// State
  final RxBool isRegistered = false.obs;
  final RxBool isCompleted = false.obs;
  final isOwner = false.obs;
  final lockTimer = ''.obs;
  Timer? _timer;
  DateTime? lockUntil;
  final attendanceConfirmed = false.obs;

  bool get isLocked => lockTimer.value.isEmpty && lockUntil != null;

  void setOwner(bool value) => isOwner.value = value;

  void initLockTimer(DateTime lockUntilTime) {
    lockUntil = lockUntilTime;
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _tick();
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

  //// Select Winner (0=GroupA, 1=GroupB, 2=Draw)
  final RxInt selectedWinner = 0.obs;

  ///// Notes
  final notesController = TextEditingController();
  final List<RosterGroup> rosterGroups = [
    const RosterGroup(
      image: 'assets/images/hank_out_party_img.jpg',
      name: 'Group A',
      memberCount: '6 Members Registered',
      avatars: [
        'assets/images/person1_img.jpg',
        'assets/images/onboarding5_img.jpg',
        'assets/images/hank_out_party_img.jpg',
      ],
      extraCount: 9,
    ),
    const RosterGroup(
      image: 'assets/images/hank_out_park_party_img.jpg',
      name: 'Group B',
      memberCount: '8 Members Registered',
      avatars: [
        'assets/images/person1_img.jpg',
        'assets/images/onboarding5_img.jpg',
      ],
      extraCount: 6,
    ),
  ];

  final RxList<LocationVoteItem> locationVotes = <LocationVoteItem>[
    const LocationVoteItem(
      image: 'assets/images/location_img1.jpg',
      name: 'Green Fields Arena',
      votes: 2,
      totalVotes: 5,
      isSelected: false,
    ),
    const LocationVoteItem(
      image: 'assets/images/location_img2.jpg',
      name: 'Central Sports Complex',
      votes: 3,
      totalVotes: 5,
    ),
  ].obs;

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


  void onRegister() {
    final teamName = rosterGroups[0].name;

    AppDialog.show(
      icon: Icons.assignment_ind_outlined,
      iconBackgroundColor: ConstColor.primaryColor.withAlpha(30),
      iconColor: ConstColor.primaryColor,
      title: 'Register Confirmation',
      titleColor: const Color(0xFF2E7D32),
      content: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: ConstColor.textColor,
          ),
          children: [
            const TextSpan(text: 'You are about to register for this competition as a member of '),
            TextSpan(
              text: teamName,
              style: const TextStyle(fontWeight: FontWeight.w700, color: ConstColor.black),
            ),
          ],
        ),
      ),
      secondaryButtonText: ConstString.cancel,
      onSecondaryTap: () => Get.back(),
      primaryButtonText: ConstString.confirm,
      onPrimaryTap: () {
        Get.back();
        _showRegisterSuccessDialog(teamName);
      },
    );
  }

  void _showRegisterSuccessDialog(String teamName) {
    AppDialog.show(
      icon: Icons.check,
      iconBackgroundColor: const Color(0xFF22C55E),
      iconColor: Colors.white,
      title: 'Awesome!',
      titleColor: ConstColor.grey,
      message: "You're successfully registered",
      primaryButtonText: 'Done',
      onPrimaryTap: () {
        Get.back();
        isRegistered.value = true;
      },
      autoDismissDuration: const Duration(seconds: 3),
      onAutoDismiss: () {
        isRegistered.value = true;
      },
    );
  }

  void selectLocation(LocationVoteItem selected) {
    if (!isRegistered.value) {
      AppSnackBar.message("Please register to vote for a location.");
      return;
    }
    if (isLocked) return;
    for (int i = 0; i < locationVotes.length; i++) {
      locationVotes[i] = locationVotes[i].copyWith(
        isSelected: locationVotes[i] == selected,
      );
    }
  }

  void onNavigate() {
    Get.toNamed(AppRoutes.planMapScreen);
  }

  void onConfirmAttendance() {
    attendanceConfirmed.value = true;
    Get.toNamed(AppRoutes.attendanceTipsScreen);
    AppSnackBar.success("Attendance confirmed successfully! 🎉");
  }

  void onChat() {
    Get.toNamed(AppRoutes.groupPlanChatScreen);
  }

  void onMarkCompleted() => Get.toNamed(AppRoutes.addMatchResultScreen);

  void onEditCompetition() => Get.toNamed(AppRoutes.setMatchDetailsScreen);

  void onInviteFriends() {
    Get.toNamed(AppRoutes.inviteFriendsListScreen);
  }

  void backToHome() =>
  Get.offAllNamed(AppRoutes.navBar, arguments: 0);

  void selectWinner(int index) => selectedWinner.value = index;

  void confirmResult() {
    isCompleted.value = true;
    // Get.back();
    Get.toNamed(AppRoutes.finalScoreScreen);
    AppSnackBar.success("Match result confirmed successfully.✅");
  }

  void onEditResult() => Get.toNamed(AppRoutes.addMatchResultScreen);

  @override
  void onInit() {
    super.onInit();
    initLockTimer(DateTime.now().add(const Duration(seconds: 30)));
  }

  @override
  void onClose() {
    notesController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}