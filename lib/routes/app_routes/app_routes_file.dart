import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/plan_details_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/LoginScreen/login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/phone_login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/phone_number_verify_otp_screen.dart';
import '../../screens/BaseScreen/CreateProfileScreen/VerifyIdScreen/profile_photo_intro_screens.dart';
import '../../screens/BaseScreen/CreateProfileScreen/VerifyIdScreen/verify_id_screen.dart';
import '../../screens/BaseScreen/CreateProfileScreen/create_profile_screen.dart';
import '../../screens/BaseScreen/NavBar/nav_bar.dart';
import '../../screens/BaseScreen/OnboardingScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityDetailScreen/community_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityScreen/community_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/GroupDetailScreen/group_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FeedAllScreen/feed_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/ForYouScreen/for_you_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/attendance_tips_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/block_user_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/help_center_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/report_problem_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/support_help_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HowDidItGoScreen/how_didIt_go_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HostProfileScreen/host_profile_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/VibeScreen/vibe_screen.dart';
import '../bindings/authBindings.dart';
import 'app_routes.dart';

List<GetPage> appRouteFile = <GetPage>[


  ////////////Auth Part////////////
  GetPage(name: AppRoutes.splashScreen,page: () => SplashScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.onboardingScreen,page: () => OnboardingScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.loginScreen,page: () => LoginScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.phoneLoginScreen,page: () => PhoneLoginScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.phoneNumberVerifyOtpScreen,page: () => PhoneNumberVerifyOtpScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.createProfileScreen,page: () => CreateProfileScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.verifyIdScreen,page: () => VerifyIdScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.profilePhotoScreen,page: () => ProfilePhotoScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.addIntroScreen,page: () => AddIntroScreen(),binding: AppBindings()),



  ////////////nav bar Part////////////
  GetPage(name: AppRoutes.navBar,page: () => NavBar(),binding: AppBindings()),

  ////////////Home Screen Part////////////
  GetPage(name: AppRoutes.homeScreen,page: () => HomeScreen(),binding: AppBindings()),
  // for you screen
  GetPage(name: AppRoutes.forYouScreen,page: () => ForYouScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.planDetailsScreen,page: () => PlanDetailsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.hostProfileScreen,page: () => HostProfileScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.howDidItGoScreen,page: () => HowDidItGoScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.helpCenterScreen,page: () => HelpCenterScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.attendanceTipsScreen,page: () => AttendanceTipsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.reportProblemScreen,page: () => ReportProblemScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.blockUserScreen,page: () => BlockUserScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.supportHelpScreen,page: () => SupportHelpScreen(),binding: AppBindings()),
  //vibe screen
  GetPage(name: AppRoutes.vibeScreen,page: () => VibeScreen(),binding: AppBindings()),

  // Feed Screen
  GetPage(name: AppRoutes.feedScreen,page: () => FeedScreen(),binding: AppBindings()),

  // Community Screen
  GetPage(name: AppRoutes.communityScreen,page: () => CommunityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.communityDetailScreen,page: () => CommunityDetailScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.groupDetailScreen,page: () => GroupDetailScreen(),binding: AppBindings()),




];