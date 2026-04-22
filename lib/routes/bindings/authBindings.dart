import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/AuthAllScreen/LoginScreen/Controller/login_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/OnboardingScreen/Controller/onboarding_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/SplashScreen/Controller/splash_screen_controller.dart';

import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/Controller/phone_login_controller.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/Controller/phone_number_verify_otp_controller.dart';
import '../../screens/BaseScreen/CreateProfileScreen/Controller/create_profile_controller.dart';
import '../../screens/BaseScreen/CreateProfileScreen/VerifyIdScreen/verify_id_screen.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {

    //=========Auth Controller Part=========//
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => PhoneLoginController());
    Get.lazyPut(() => PhoneNumberVerifyOtpController());
    Get.lazyPut(() => CreateProfileController());


  }
}