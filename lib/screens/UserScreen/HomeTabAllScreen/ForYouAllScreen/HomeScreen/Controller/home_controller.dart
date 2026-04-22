import 'dart:ui';

import 'package:get/get.dart';

import '../../../../../../constant/const_color.dart';

// ---- Data Models ----
class MeetupItem {
  final String icon;
  final String title;
  final String subtitle;
  final Color cardColor;
  final Color iconColor;

  const MeetupItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cardColor,
    required this.iconColor,
  });
}

class EventItem {
  final String image;
  final String title;
  final String tag;
  final String location;
  final String date;
  final String time;
  final String joined;
  final bool isFreeEntry;
  final bool isOpen;

  const EventItem({
    required this.image,
    required this.title,
    required this.tag,
    required this.location,
    required this.date,
    required this.time,
    required this.joined,
    this.isFreeEntry = false,
    this.isOpen = true,
  });
}

class PersonItem {
  final String image;
  final String name;
  final String bio;
  final String distance;

  const PersonItem({
    required this.image,
    required this.name,
    required this.bio,
    required this.distance,
  });
}

class HomeController extends GetxController {
  // ---- Tabs ----
  final tabs = ['For You', 'Vibe', 'Feed', 'Community'];
  final selectedTab = 0.obs;

  // ---- Easy Meetups ----
  final meetups = <MeetupItem>[
    const MeetupItem(
      icon: 'assets/icons/cofee_cup_icon.svg',
      title: '30-min coffee catch-up',
      subtitle: 'Short & sweet',
      cardColor: Color(0xFFFFF3E0),
      iconColor: Color(0xFFFF9800),
    ),
    const MeetupItem(
      icon: 'assets/icons/tree_icon.svg',
      title: 'Quiet walk in evening',
      subtitle: 'Nature & calm',
      cardColor: Color(0xFFE8F5E9),
      iconColor: Color(0xFF4CAF50),
    ),
    const MeetupItem(
      icon: 'assets/icons/cofee_cup_icon.svg',
      title: '30-min coffee catch-up',
      subtitle: 'Short & sweet',
      cardColor: Color(0xFFEDE9FF),
      iconColor: ConstColor.primaryColor,
    ),
  ];

  // ---- Upcoming Events ----
  final upcomingEvents = <EventItem>[
    const EventItem(
      image: 'assets/images/hank_out_party_img.jpg',
      title: 'Hang out at the park',
      tag: '🌿 Nature Walk',
      location: 'Central Park West, NYC',
      date: 'Saturday, 24 June',
      time: '6:30 PM Today',
      joined: '3/6 joined',
      isFreeEntry: true,
      isOpen: true,
    ),
    const EventItem(
      image: 'assets/images/hank_out_park_party_img.jpg',
      title: 'Hang out at the park',
      tag: '🌿 Nature Walk',
      location: 'Central Park West, NYC',
      date: 'Saturday, 24 June',
      time: '6:30 PM Today',
      joined: '3/6 joined',
      isFreeEntry: true,
      isOpen: true,
    ),
  ];

  // ---- People ----
  final people = <PersonItem>[
    const PersonItem(
      image: 'assets/images/person1.jpg',
      name: 'Maya Sen',
      bio: 'Plant lover, Tea drinker',
      distance: '0.8 km away',
    ),
    const PersonItem(
      image: 'assets/images/person2.jpg',
      name: 'Maya Sen',
      bio: 'Plant lover, Tea drinker',
      distance: '0.8 km away',
    ),
  ].obs;

  // ---- Actions ----
  void onInviteFriends() {
    // TODO: invite friends logic
  }

  void onSeeAllEvents() {
    // TODO: navigate to all events
  }

  void onSeeAllPeople() {
    // TODO: navigate to all people
  }

  void onSayHello(PersonItem person) {
    // TODO: say hello logic
  }
}