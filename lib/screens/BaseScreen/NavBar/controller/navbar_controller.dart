import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages =[
    const HomeScreen(),
    const _PlaceholderScreen(label: 'My Plan'),
    const _PlaceholderScreen(label: 'Add'),
    const _PlaceholderScreen(label: 'Message'),
    const _PlaceholderScreen(label: 'Profile'),
  ];

  void onTabTap(int index) {
    if (index == 2) {
      // TODO: open add/create plan bottom sheet
      return;
    }
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is int) {
      selectedIndex.value = Get.arguments as int;
    }
    super.onInit();
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text(label)),
  );
}