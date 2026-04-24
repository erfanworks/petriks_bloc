import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

// ---- Model ----
class OneToOneMeetupItem {
  final String personImage;
  final String personName;
  final String language;
  final String distance;
  final String eventImage;
  final String tag;
  final String eventTitle;
  final String location;
  final String date;
  final String time;
  final bool isFreeEntry;

  const OneToOneMeetupItem({
    required this.personImage,
    required this.personName,
    required this.language,
    required this.distance,
    required this.eventImage,
    required this.tag,
    required this.eventTitle,
    required this.location,
    required this.date,
    required this.time,
    this.isFreeEntry = false,
  });
}

// ---- Controller ----
class OneToOneMeetupController extends GetxController {
  // ---- Feeling Filter ----
  final feelingFilters = ['Quiet', 'Easy Going', 'Social', 'Lively'];
  final selectedFeeling = 1.obs;

  // ---- Meet Filter ----
  final meetFilters = ['Everyone', 'Women', 'Men'];
  final selectedMeet = 0.obs;

  // ---- Meetup Items ----
  final List<OneToOneMeetupItem> meetups = [
    const OneToOneMeetupItem(
      personImage: 'assets/images/person1_img.jpg',
      personName: 'John Lura',
      language: 'English',
      distance: '0.8 km away',
      eventImage: 'assets/images/hank_out_party_img.jpg',
      tag: 'Casual Hangout',
      eventTitle: 'Coffee Time',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      time: '6:30 PM Today',
      isFreeEntry: true,
    ),
    const OneToOneMeetupItem(
      personImage: 'assets/images/onboarding5_img.jpg',
      personName: 'John Lura',
      language: 'English',
      distance: '0.8 km away',
      eventImage: 'assets/images/hank_out_park_party_img.jpg',
      tag: 'Casual Hangout',
      eventTitle: 'Coffee Time',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      time: '6:30 PM Today',
      isFreeEntry: true,
    ),
    const OneToOneMeetupItem(
      personImage: 'assets/images/person1_img.jpg',
      personName: 'John Lura',
      language: 'English',
      distance: '0.8 km away',
      eventImage: 'assets/images/party_place_img.jpg',
      tag: 'Casual Hangout',
      eventTitle: 'Coffee Time',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      time: '6:30 PM Today',
      isFreeEntry: true,
    ),
  ];

  // ---- Actions ----
  void onViewProfile(OneToOneMeetupItem item) => Get.toNamed(AppRoutes.hostProfileScreen);
  void onEventTap(OneToOneMeetupItem item) => Get.toNamed('/plan-details');
}