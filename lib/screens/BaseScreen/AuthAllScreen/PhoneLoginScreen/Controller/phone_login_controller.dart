import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class PhoneLoginController extends GetxController {
  final phoneController = TextEditingController();
  final phoneFormKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  // ---- Send OTP ----
  Future<void> sendOtp() async {
    if (!phoneFormKey.currentState!.validate()) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.toNamed(AppRoutes.phoneNumberVerifyOtpScreen);
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