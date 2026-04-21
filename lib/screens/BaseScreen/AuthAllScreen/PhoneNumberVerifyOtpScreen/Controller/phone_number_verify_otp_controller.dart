import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberVerifyOtpController extends GetxController {
  // ---- OTP Controllers & FocusNodes ----
  final List<TextEditingController> otpControllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
  List.generate(4, (_) => FocusNode());

  // ---- Timer ----
  final RxInt timerSeconds = 42.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  // ---- Loading ----
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    startOtpTimer();
  }

  // ---- Start Timer ----
  void startOtpTimer() {
    timerSeconds.value = 42;
    canResend.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // ---- Format Timer ----
  String get formattedTimer {
    final minutes = (timerSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (timerSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes.$seconds';
  }

  // ---- OTP auto-jump logic ----
  void onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  // ---- Get entered OTP ----
  String get enteredOtp =>
      otpControllers.map((c) => c.text).join();

  // ---- Verify OTP ----
  Future<void> verifyOtp() async {
    if (enteredOtp.length < 4) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Replace with real API
    isLoading.value = false;
    // TODO: navigate to next screen
  }

  // ---- Resend OTP ----
  void resendOtp() {
    if (!canResend.value) return;
    startOtpTimer();
    // TODO: call resend API
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}