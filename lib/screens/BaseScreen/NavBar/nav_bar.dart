import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/BaseScreen/NavBar/widgets/nav_bar_bottom.dart';
import '../../../constant/const_color.dart';
import 'controller/navbar_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavbarController());

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: controller.pages,
      )),
      bottomNavigationBar: Obx(() => NavBarBottom(
        selectedIndex: controller.selectedIndex.value,
        onTap: controller.onTabTap,
      )),
    );
  }
}