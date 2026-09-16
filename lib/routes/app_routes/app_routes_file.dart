import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/plan_details_screen.dart';
import 'package:petriks_flutter_app/screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/CurrentMoodScreen/current_mood_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/LoginScreen/login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneLoginScreen/phone_login_screen.dart';
import '../../screens/BaseScreen/AuthAllScreen/PhoneNumberVerifyOtpScreen/phone_number_verify_otp_screen.dart';
import '../../screens/BaseScreen/CreateProfileScreen/VerifyIdScreen/profile_photo_intro_screens.dart';
import '../../screens/BaseScreen/CreateProfileScreen/VerifyIdScreen/verify_id_screen.dart';
import '../../screens/BaseScreen/CreateProfileScreen/create_profile_screen.dart';
import '../../screens/BaseScreen/NavBar/nav_bar.dart';
import '../../screens/BaseScreen/OnboardingScreen/onboarding_screen.dart';
import '../../screens/BaseScreen/SplashScreen/splash_screen.dart';
import '../../screens/UserScreen/CreatePlanTabAllScreen/CreatePlanScreen/create_plan_screen.dart';
import '../../screens/UserScreen/CreatePlanTabAllScreen/FreeTrialEndedScree/free_trial_ended_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityDetailScreen/community_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CommunityScreen/community_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCommunityScreen/create_community_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCompetitionScreen/choose_groups_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCompetitionScreen/final_review_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCompetitionScreen/select_activity_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateCompetitionScreen/set_match_details_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/CreateGroup/create_group_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/GroupDetailScreen/group_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/GroupDetailScreen/join_group_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityDetailScreen/edit_community_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityDetailScreen/my_community_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyGroupDetailScreen/edit_group_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyGroupDetailScreen/my_group_detail_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/ViewCompetitionScreen/CompetitionExperienceScreen/competition_experience_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/ViewCompetitionScreen/add_match_result_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/ViewCompetitionScreen/final_score_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/ViewCompetitionScreen/view_competition_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FeedAllScreen/CommentScreen/comment_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FeedAllScreen/CreatePostScreen/create_post_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/FeedAllScreen/FeedScreen/feed_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/ForYouScreen/for_you_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/attendance_tips_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/block_user_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/help_center_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/report_problem_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HelpCenterScreen/support_help_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/HowDidItGoScreen/how_didIt_go_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/plan_map_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/HostProfileScreen/host_profile_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/one_to_one_meetup_details_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupScreen/one_to_one_meetup_screen.dart';
import '../../screens/UserScreen/HomeTabAllScreen/VibeAllScreen/VibeScreen/vibe_screen.dart';
import '../../screens/UserScreen/MessageTabAllScreen/ChatScreen/chat_screen.dart';
import '../../screens/UserScreen/MessageTabAllScreen/DirectChatScreen/direct_chat_screen.dart';
import '../../screens/UserScreen/MessageTabAllScreen/GroupPlanChatScreen/group_plan_chat_screen.dart';
import '../../screens/UserScreen/MessageTabAllScreen/PlanChatScreen/plan_chat_screen.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/BoostPlanScreen/boost_plan_screen.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/DetailsScreen/FeedBackScreen/feed_back_screen.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/DetailsScreen/JoinedPlanDetailsScreen/JoinedPlanUserReport/joined_plan_user_report.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/DetailsScreen/JoinedPlanDetailsScreen/joined_plan_details_screen.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/DetailsScreen/created_plan_details_screen.dart';
import '../../screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/DetailsScreen/edit_plan_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/ConnectionScreen/connection_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/NotificationScreen/notification_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/ProfileScreen/profile_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/BlockUserScreen/block_user_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/EditProfileScreen/edit_profile_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/InviteFriendsScreen/invite_friends_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/AboutUsScreen/about_us_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/FAQScreen/faq_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/LanguagePreferenceScreen/language_preference_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/MeetPreferenceScreen/meet_preference_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/PrivacyPolicyScreen/privacy_policy_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/SettingsScreen/settings_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/SupportContactScreen/support_contact_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/TermsConditionScreen/terms_condition_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/TravelTimeScreen/travel_time_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/VibeSocialEnergyScreen/vibe_social_energy_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SettingsAllScreen/WeeklyAvailabilityScreen/weekly_availability_screen.dart';
import '../../screens/UserScreen/ProfileTabAllScreen/SubscriptionScreen/subscription_screen.dart';
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
  // GetPage(name: AppRoutes.addIntroScreen,page: () => AddIntroScreen(),binding: AppBindings()),



  ////////////nav bar Part////////////
  GetPage(name: AppRoutes.navBar,page: () => NavBar(),binding: AppBindings()),

  ////////////Home Screen Part////////////
  GetPage(name: AppRoutes.homeScreen,page: () => HomeScreen(),binding: AppBindings()),
  // for you screen
  GetPage(name: AppRoutes.forYouScreen,page: () => ForYouScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.planDetailsScreen,page: () => PlanDetailsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.planMapScreen,page: () => PlanMapScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.hostProfileScreen,page: () => HostProfileScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.howDidItGoScreen,page: () => HowDidItGoScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.helpCenterScreen,page: () => HelpCenterScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.attendanceTipsScreen,page: () => AttendanceTipsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.reportProblemScreen,page: () => ReportProblemScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.blockUserScreen,page: () => BlockUserScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.supportHelpScreen,page: () => SupportHelpScreen(),binding: AppBindings()),
  //vibe screen
  GetPage(name: AppRoutes.vibeScreen,page: () => VibeScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.oneToOneMeetupScreen,page: () => OneToOneMeetupScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.oneToOneMeetupDetailsScreen,page: () => OneToOneMeetupDetailsScreen(),binding: AppBindings()),
  // GetPage(name: AppRoutes.meetupGroupDetailsScreen,page: () => MeetupGroupDetailsScreen(),binding: AppBindings()),


  // Feed Screen
  GetPage(name: AppRoutes.feedScreen,page: () => FeedScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.createPostScreen,page: () => CreatePostScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.commentScreen,page: () => CommentScreen(),binding: AppBindings()),

  // Community Screen
  GetPage(name: AppRoutes.communityScreen,page: () => CommunityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.communityDetailScreen,page: () => CommunityDetailScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.groupDetailScreen,page: () => GroupDetailScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.joinGroupScreen,page: () => JoinGroupScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.myCommunityDetailScreen,page: () => MyCommunityDetailScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.editCommunityScreen,page: () => EditCommunityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.editGroupScreen,page: () => EditGroupScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.myGroupDetailScreen,page: () => MyGroupDetailScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.createCommunityScreen,page: () => CreateCommunityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.createGroupScreen,page: () => CreateGroupScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.chooseGroupsScreen,page: () => ChooseGroupsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.setMatchDetailsScreen,page: () => SetMatchDetailsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.selectActivityScreen,page: () => SelectActivityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.finalReviewScreen,page: () => FinalReviewScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.viewCompetitionScreen,page: () => ViewCompetitionScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.addMatchResultScreen,page: () => AddMatchResultScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.finalScoreScreen,page: () => FinalScoreScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.competitionExperienceScreen,page: () => CompetitionExperienceScreen(),binding: AppBindings()),




  ////////////My Plan Screen Part////////////
  GetPage(name: AppRoutes.createdPlanDetailsScreen,page: () => CreatedPlanDetailsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.joinedPlanDetailsScreen,page: () => JoinedPlanDetailsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.joinedPlanUserReport,page: () => JoinedPlanUserReport(),binding: AppBindings()),
  GetPage(name: AppRoutes.feedBackScreen,page: () => FeedBackScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.editPlanScreen,page: () => EditPlanScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.boostPlanScreen,page: () => const BoostPlanScreen(),),


  ////////////My Plan Screen Part////////////
  GetPage(name: AppRoutes.createPlanScreen,page: () => CreatePlanScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.freeTrialEndedScreen,page: () => FreeTrialEndedScreen(),binding: AppBindings()),


  ////////////Messaging Screen Part////////////
  GetPage(name: AppRoutes.chatScreen,page: () => ChatScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.directChatScreen,page: () => DirectChatScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.planChatScreen,page: () => PlanChatScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.groupPlanChatScreen,page: () => GroupPlanChatScreen(),binding: AppBindings()),


  ////////////Profile Screen Part////////////
  GetPage(name: AppRoutes.profileScreen,page: () => ProfileScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.settingsScreen,page: () => SettingsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.subscriptionScreen,page: () => SubscriptionScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.editProfileScreen,page: () => EditProfileScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.languagePreferenceScreen,page: () => LanguagePreferenceScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.travelTimeScreen,page: () => TravelTimeScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.vibeSocialEnergyScreen,page: () => VibeSocialEnergyScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.meetPreferenceScreen,page: () => MeetPreferenceScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.blockUserListScreen,page: () => BlockUserListScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.termsConditionScreen,page: () => TermsConditionScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.privacyPolicyScreen,page: () => PrivacyPolicyScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.faqScreen,page: () => FAQScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.aboutUsScreen,page: () => AboutUsScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.inviteFriendsListScreen,page: () => InviteFriendsListScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.connectionScreen,page: () => ConnectionScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.notificationScreen,page: () => NotificationScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.currentMoodScreen,page: () => CurrentMoodScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.weeklyAvailabilityScreen,page: () => WeeklyAvailabilityScreen(),binding: AppBindings()),
  GetPage(name: AppRoutes.supportContactScreen,page: () => SupportContactScreen(),binding: AppBindings()),


];