import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/AuthAllScreen/LoginScreen/Controller/login_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/OnboardingScreen/Controller/onboarding_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/SplashScreen/Controller/splash_screen_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/FeedAllScreen/Controller/feed_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/HostProfileScreen/Controller/host_profile_controller.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/Controller/phone_login_controller.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/Controller/phone_number_verify_otp_controller.dart';
import '../../screens/BaseScreen/CreateProfileScreen/Controller/create_profile_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/ForYouScreen/Controller/for_you_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/VibeScreen/Controller/vibe_controller.dart';


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
    Get.lazyPut(() => PlanDetailsController());
    Get.lazyPut(() => HostProfileController());
    Get.lazyPut(() => ForYouController());
    Get.lazyPut(() => VibeController());
    Get.lazyPut(() => FeedController());


  }
}