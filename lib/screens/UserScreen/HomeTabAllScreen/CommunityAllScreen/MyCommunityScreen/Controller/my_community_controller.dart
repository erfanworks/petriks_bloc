import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyCommunityModel {
  final String image;
  final String tag;
  final String title;
  final String role;
  final String description;
  final String members;
  final String groups;
  final String competitions;

  MyCommunityModel({
    required this.image,
    required this.tag,
    required this.title,
    required this.role,
    required this.description,
    required this.members,
    required this.groups,
    required this.competitions,
  });
}

class MyCommunityController extends GetxController {
  final myCommunities = <MyCommunityModel>[
    MyCommunityModel(
      image: 'assets/images/location_img2.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      role: 'Owner',
      description:
          'High-intensity street workouts and community-led track sessions in the heart of the city.',
      members: '1,240',
      groups: '12',
      competitions: '4',
    ),
    MyCommunityModel(
      image: 'assets/images/location_img1.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      role: 'Member',
      description:
          'High-intensity street workouts and community-led track sessions in the heart of the city.',
      members: '1,240',
      groups: '12',
      competitions: '4',
    ),
    MyCommunityModel(
      image: 'assets/images/location_img1.jpg',
      tag: 'FITNESS',
      title: 'Urban Athletes',
      role: 'Member',
      description:
          'High-intensity street workouts and community-led track sessions in the heart of the city.',
      members: '1,240',
      groups: '12',
      competitions: '4',
    ),
  ];
}
