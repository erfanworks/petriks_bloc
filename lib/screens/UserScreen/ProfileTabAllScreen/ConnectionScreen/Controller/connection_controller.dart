import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ConnectionUser {
  final String image;
  final String name;
  final String username;
  final RxBool isFollowing;

  ConnectionUser({
    required this.image,
    required this.name,
    required this.username,
    bool following = false,
  }) : isFollowing = following.obs;
}

// Connection Controller
class ConnectionController extends GetxController {
  final selectedTab = 0.obs;

  final followers = <ConnectionUser>[
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235'),
  ].obs;

  final following = <ConnectionUser>[
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
    ConnectionUser(image: 'assets/images/person1_img.jpg', name: 'Elena Rodriguez', username: 'Elena@1235', following: true),
  ].obs;

  void onTabChanged(int index) => selectedTab.value = index;

  void onFollowToggle(ConnectionUser user) {
    user.isFollowing.value = !user.isFollowing.value;
    // TODO: API call
  }
}