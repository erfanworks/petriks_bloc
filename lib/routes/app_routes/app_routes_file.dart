import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/BaseScreen/AuthAllScreen/LoginScreen/login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/phone_login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/phone_number_verify_otp_screen.dart';
import '../../screens/BaseScreen/OnboardingScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../bindings/authBindings.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[


  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen,page: () => SplashScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.onboardingScreen,page: () => OnboardingScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.loginScreen,page: () => LoginScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.phoneLoginScreen,page: () => PhoneLoginScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.phoneNumberVerifyOtpScreen,page: () => PhoneNumberVerifyOtpScreen(),binding: AppBindings()),




];