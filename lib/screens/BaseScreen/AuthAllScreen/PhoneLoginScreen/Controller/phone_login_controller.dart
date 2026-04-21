import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneLoginController extends GetxController {
  final phoneController = TextEditingController();
  final phoneFormKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  // ---- Send OTP ----
  Future<void> sendOtp() async {
    if (!phoneFormKey.currentState!.validate()) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Replace with real API
    isLoading.value = false;
    Get.toNamed('/verify-otp');
  }

  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}