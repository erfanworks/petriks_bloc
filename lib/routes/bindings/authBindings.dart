import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/OnboardingScreen/Controller/onboarding_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/SplashScreen/Controller/splash_screen_controller.dart';


class AuthBindings extends Bindings {
  @override
  void dependencies() {

    //=========Auth Controller Part=========//
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => OnboardingController());


  }
}