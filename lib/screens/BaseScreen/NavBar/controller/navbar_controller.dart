import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  // ── Placeholder screens for tabs not yet built ──
  final List<Widget> pages = [
    // const HomeScreen(),
    const _PlaceholderScreen(label: 'My Plan'),
    const _PlaceholderScreen(label: 'Add'),
    const _PlaceholderScreen(label: 'Message'),
    const _PlaceholderScreen(label: 'Profile'),
  ];

  void onTabTap(int index) {
    // Center + button (index 2) → custom action, no tab switch
    if (index == 2) {
      // TODO: open add/create plan bottom sheet
      return;
    }
    selectedIndex.value = index;
  }
}

// ── Temporary placeholder until screens are ready ──
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text(label)),
  );
}