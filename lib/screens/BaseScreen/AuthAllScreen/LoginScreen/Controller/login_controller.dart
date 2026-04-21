import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class LoginController extends GetxController {
  // ---- Social Login ----
  void continueWithGoogle() {
    // TODO: Google sign in logic
  }

  void continueWithFacebook() {
    // TODO: Facebook sign in logic
  }

  void continueWithPhone() {
    Get.toNamed(AppRoutes.phoneLoginScreen);
  }

  void goToSignUp() {
    Get.toNamed('/signup');
  }

  void openTerms() {
    // TODO: open terms & conditions
  }

  void openPrivacyPolicy() {
    // TODO: open privacy policy
  }
}