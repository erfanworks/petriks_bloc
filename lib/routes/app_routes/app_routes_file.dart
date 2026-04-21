import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/BaseScreen/AuthAllScreen/LoginScreen/login_screen.dart';
import '../../screens/BaseScreen/OnboardingScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[


  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen,page: () => SplashScreen()),
  GetPage(name: AppRoutes.onboardingScreen,page: () => OnboardingScreen()),
  GetPage(name: AppRoutes.loginScreen,page: () => LoginScreen()),




];