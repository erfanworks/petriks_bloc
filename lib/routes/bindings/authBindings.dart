import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/AuthAllScreen/LoginScreen/Controller/login_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/NavBar/controller/navbar_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/OnboardingScreen/Controller/onboarding_controller.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/SplashScreen/Controller/splash_screen_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityDetailScreen/Controller/community_detail_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCommunityScreen/Controller/create_community_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateGroup/Controller/create_group_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityDetailScreen/Controller/my_community_detail_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/FeedAllScreen/Controller/feed_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/HostProfileScreen/Controller/host_profile_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/VibeAllScreen/GroupDetailScreen/Controller/group_details_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MessageTabAllScreen/ChatScreen/Controller/chat_controller.dart';
import 'package:petriks_flutter_app/screens/UserScreen/ProfileTabAllScreen/ProfileScreen/Controller/profile_controller.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/Controller/phone_login_controller.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/Controller/phone_number_verify_otp_controller.dart';
import '../../screens/BaseScreen/CreateProfileScreen/Controller/create_profile_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityScreen/Controller/community_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCompetitionScreen/Controller/create_competition_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityScreen/Controller/my_community_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/ViewCompetitionScreen/Controller/view_competition_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/ForYouScreen/Controller/for_you_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/Controller/one_to_one_meetup_details_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupScreen/Controller/one_to_one_meetup_controller.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/VibeScreen/Controller/vibe_controller.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsScreen/Controller/settings_controller.dart';


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

    //=========User Screen All Controller Part=========//
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PlanDetailsController());
    Get.lazyPut(() => HostProfileController());
    Get.lazyPut(() => ForYouController());
    Get.lazyPut(() => VibeController());
    Get.lazyPut(() => FeedController());
    Get.lazyPut(() => CommunityController());
    Get.lazyPut(() => CommunityDetailController());
    Get.lazyPut(() => MyCommunityController());
    Get.lazyPut(() => MyCommunityDetailController());
    Get.lazyPut(() => CreateCommunityController());
    Get.lazyPut(() => CreateGroupController());
    Get.lazyPut(() => CreateCompetitionController());
    Get.lazyPut(() => ViewCompetitionController());
    Get.lazyPut(() => OneToOneMeetupController());
    Get.lazyPut(() => MeetupGroupDetailsController());
    Get.lazyPut(() => OneToOneMeetupDetailsController());
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SettingsController());


  }
}