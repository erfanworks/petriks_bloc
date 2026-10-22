import 'package:get/get.dart';

class BlockedUserModel {
  final String image;
  final String name;
  final String blockedSince;
  const BlockedUserModel({
    required this.image,
    required this.name,
    required this.blockedSince,
  });
}

class BlockService extends GetxService {
  static BlockService get to => Get.isRegistered<BlockService>()
      ? Get.find<BlockService>()
      : Get.put(BlockService(), permanent: true);

  // TODO(API): নিচের sample data মুছে API থেকে আনবেন
  final RxList<BlockedUserModel> blockedUsers = <BlockedUserModel>[
    const BlockedUserModel(image: 'assets/images/onboarding1_img.jpg', name: 'Elena Rodriguez', blockedSince: 'Oct 12, 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding2_img.jpg', name: 'Marcus Sterling', blockedSince: 'Sep 04, 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding1_img.jpg', name: 'Sarah Jenkins', blockedSince: 'Aug 21, 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding2_img.jpg', name: 'David Chen', blockedSince: 'Jul 15, 2023'),
  ].obs;

  bool isBlocked(String name) => blockedUsers.any((u) => u.name == name);

  void block({required String name, required String image}) {
    if (isBlocked(name)) return;
    blockedUsers.insert(
      0,
      BlockedUserModel(image: image, name: name, blockedSince: _today()),
    );
  }

  void unblock(String name) => blockedUsers.removeWhere((u) => u.name == name);

  String _today() {
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final d = DateTime.now();
    return '${m[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, ${d.year}';
  }
}
