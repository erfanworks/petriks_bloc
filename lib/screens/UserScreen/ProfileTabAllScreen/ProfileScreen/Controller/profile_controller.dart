import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart'; // TODO: adjust to actual relative path

class InterestModel {
  final String icon;
  final String label;
  const InterestModel({required this.icon, required this.label});
}

class CommunityModel {
  final String image;
  final String name;
  final String memberCount;
  const CommunityModel({required this.image, required this.name, required this.memberCount});
}

class BadgeModel {
  final String icon;
  final String title;
  final String subtitle;
  const BadgeModel({required this.icon, required this.title, required this.subtitle});
}

class InviteFriendModel {
  final String image;
  final String name;
  final String username;
  final RxBool isInvited;
  InviteFriendModel({required this.image, required this.name, required this.username, bool invited = false})
      : isInvited = invited.obs;
}

class ProfileController extends GetxController {
  final userName       = 'Rahim, 26'.obs;
  final userLocation   = 'Dhaka'.obs;
  final userLanguages  = 'English, Bangla'.obs;
  final userBio        = 'Passionate about exploring local culture and finding the best street food in Dhaka. Always up for a friendly cricket match or a tech talk!'.obs;
  final followerCount  = 24.obs;
  final followingCount = 18.obs;
  final isPremium      = true.obs;
  final preferenceLabel = '1:1'.obs;
  final energyLabel    = 'Social'.obs;
  final travelLabel    = 'Flexible'.obs;
  final availabilityTitle    = 'Weekday evenings';
  final availabilitySubtitle = 'Perfect for after-work hangouts and dinners.';
  final moodEmoji = '🙏';
  final moodTitle = 'Do something calm';

  // ===== ADDED: Intro Video state =====
  final introVideoPath = Rx<String?>(null);
  final isIntroVideoActionVisible = false.obs;
  // =====================================

  final interests = <InterestModel>[
    const InterestModel(icon: 'assets/icons/cofee_cup_icon.svg',  label: 'Coffee & Brunch'),
    const InterestModel(icon: 'assets/icons/hiking_outdoors_icon.svg',  label: 'Hiking & Outdoors'),
    const InterestModel(icon: 'assets/icons/art_icon.svg',     label: 'Art & Museums'),
    const InterestModel(icon: 'assets/icons/travel_icon.svg',  label: 'Travel'),
    const InterestModel(icon: 'assets/icons/cooking_icon.svg', label: 'Cooking'),
    const InterestModel(icon: 'assets/icons/camera_icon.svg',   label: 'Photography'),
    const InterestModel(icon: 'assets/icons/music_icon.svg',   label: 'Live Music'),
  ];

  final badges = <BadgeModel>[
    const BadgeModel(icon: 'assets/icons/clock_icon.svg',     title: 'On-time host',   subtitle: '12 Plans'),
    const BadgeModel(icon: 'assets/icons/person_icon.svg', title: 'Inclusive host', subtitle: '45 Meetme'),
    const BadgeModel(icon: 'assets/icons/energy_icon.svg',     title: 'Quick reply',    subtitle: 'Under 2 HR'),
  ];

  final indicators = <BadgeModel>[
    const BadgeModel(icon: 'assets/icons/newcommer_icon.svg',     title: 'Newcomer friendly', subtitle: 'Actively welcomes members joining for their first time'),
    const BadgeModel(icon: 'assets/icons/translate_icon.svg', title: 'Multilingual host',  subtitle: 'English, Spanish, French'),
  ];

  final communities = <CommunityModel>[
    const CommunityModel(image: 'assets/images/football_play.jpg', name: 'Urban Athletes', memberCount: '12 Group'),
    const CommunityModel(image: 'assets/images/hank_out_park_party_img.jpg', name: 'Urban Athletes', memberCount: '12 Group'),
  ];

  final friends = <InviteFriendModel>[
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    InviteFriendModel(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
  ].obs;

  void onSettingsTap()                  => Get.toNamed(AppRoutes.settingsScreen);
  void onManagePlan()                   => Get.toNamed(AppRoutes.subscriptionScreen);
  void onIntroVideoTap()                => Get.toNamed('/intro-video');
  void onFollowersTap()                 => Get.toNamed(AppRoutes.connectionScreen);
  void onFollowingTap()                 => Get.toNamed(AppRoutes.connectionScreen);
  void onCommunityTap(CommunityModel c) => Get.toNamed(AppRoutes.communityDetailScreen, arguments: c);

  void onInviteFriend(int index) {
    friends[index].isInvited.value = !friends[index].isInvited.value;
    Get.toNamed(AppRoutes.inviteFriendsScreen);
  }

  // ===== ADDED: Intro Video methods =====
  Future<void> _pickIntroVideo(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickVideo(source: source);
    if (file != null) {
      introVideoPath.value = file.path;
      isIntroVideoActionVisible.value = false;
    }
  }

  void onUploadIntroVideo() {
    MediaPickerBottomSheet.show(
      title: "Select Video Source",
      onGallery: () => _pickIntroVideo(ImageSource.gallery),
      onCamera: () => _pickIntroVideo(ImageSource.camera),
    );
  }

  void onIntroVideoLongPress() {
    if (introVideoPath.value != null) {
      isIntroVideoActionVisible.value = true;
    }
  }

  void onReplaceIntroVideo() {
    isIntroVideoActionVisible.value = false;
    onUploadIntroVideo();
  }

  void onDeleteIntroVideo() {
    introVideoPath.value = null;
    isIntroVideoActionVisible.value = false;
  }
// ========================================
}