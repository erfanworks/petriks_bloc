import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class VibeEventItem {
  final String image;
  final String type;
  final String tag;
  final String title;
  final String gender;
  final String language;
  final String location;
  final String date;
  final bool isFreeEntry;
  final String hostName;
  final String hostImage;
  final bool isOpen;

  const VibeEventItem({
    required this.image,
    required this.type,
    required this.tag,
    required this.title,
    this.gender = 'Male (20-25)',
    required this.language,
    required this.location,
    required this.date,
    required this.hostName,
    required this.hostImage,
    this.isFreeEntry = false,
    this.isOpen = true,
  });
}

class VibeController extends GetxController {
  final vibeTabs = ['Group', '1:1 Meetup'];
  final selectedVibeTab = 0.obs;

  final feelingFilters = ['Quiet', 'Easy Going', 'Social', 'Lively'];
  final selectedFeeling = 1.obs;

  final meetFilters = ['Everyone', 'Women', 'Men'];
  final selectedMeet = 0.obs;

  // ---- Events ----
  final List<VibeEventItem> events = [
    const VibeEventItem(
      image: 'assets/images/night_party_img.jpg',
      type: 'Group',
      tag: 'Casual Hangout',
      title: 'Coffee Time',
      language: 'English',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      isFreeEntry: true,
      hostName: 'Marcus Chen',
      hostImage: 'assets/images/person1_img.jpg',
    ),
    const VibeEventItem(
      image: 'assets/images/hank_out_park_party_img.jpg',
      type: 'Group',
      tag: 'Casual Hangout',
      title: 'Coffee Time',
      language: 'English',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      isFreeEntry: false,
      hostName: 'Marcus Chen',
      hostImage: 'assets/images/person1_img.jpg',
    ),
    const VibeEventItem(
      image: 'assets/images/hank_out_party_img.jpg',
      type: 'Group',
      tag: 'Casual Hangout',
      title: 'Coffee Time',
      language: 'English',
      location: 'Central Park West',
      date: 'Saturday, 24 June',
      isFreeEntry: true,
      hostName: 'Marcus Chen',
      hostImage: 'assets/images/person1_img.jpg',
    ),
  ];

  // void onEventTap(VibeEventItem event) => Get.toNamed(AppRoutes.meetupGroupDetailsScreen);
  void onEventTap() => Get.toNamed(AppRoutes.planDetailsScreen);
}