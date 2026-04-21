import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class OnboardingController extends GetxController {

  // Navigate to next screen on Get Started tap
  void onGetStarted() {
    // TODO: Replace with your actual route name
    Get.toNamed(AppRoutes.loginScreen);
  }
}