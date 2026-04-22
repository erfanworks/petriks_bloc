import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/AuthAllScreen/LoginScreen/Controller/login_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/OnboardingScreen/Controller/onboarding_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/SplashScreen/Controller/splash_screen_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HomeScreen/Controller/home_controller.dart';

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

    //=========NavBar Controller Part=========//
    Get.lazyPut(() => NavbarController());

    //=========Home Controller Part=========//
    Get.lazyPut(() => HomeController());


  }
}