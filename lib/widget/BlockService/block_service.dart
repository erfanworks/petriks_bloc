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
    const BlockedUserModel(image: 'assets/images/onboarding1_img.jpg', name: 'Elena Rodriguez', blockedSince: '12 Oct 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding2_img.jpg', name: 'Marcus Sterling', blockedSince: '04 Sep 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding1_img.jpg', name: 'Sarah Jenkins', blockedSince: '21 Aug 2023'),
    const BlockedUserModel(image: 'assets/images/onboarding2_img.jpg', name: 'David Chen', blockedSince: '15 Jul 2023'),
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
    return '${d.day.toString().padLeft(2, '0')} ${m[d.month - 1]} ${d.year}';
  }
}
