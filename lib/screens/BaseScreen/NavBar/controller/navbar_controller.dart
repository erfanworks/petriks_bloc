import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/my_plan_screen.dart';
import 'package:petriks_flutter_app/screens/UserScreen/ProfileTabAllScreen/ProfileScreen/profile_screen.dart';
import '../../../UserScreen/CreatePlanTabAllScreen/CreatePlanBottomSheet/create_plan_sheet.dart';
import '../../../UserScreen/CreatePlanTabAllScreen/CreatePlanScreen/create_plan_screen.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
import '../../../UserScreen/MessageTabAllScreen/ChatScreen/chat_screen.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final isMyPlanHighlighted = false.obs;

  final List<Widget> pages =[
    const HomeScreen(),
    const MyPlanScreen(),
    const CreatePlanScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void highlightMyPlan() {
    isMyPlanHighlighted.value = true;
  }

  void onTabTap(int index) {
    if (index == 2) {
      showCreateOptionsSheet();
      return;
    }
    if (index == 1) {
      isMyPlanHighlighted.value = false;
    }
    if (index == 0) {
      Get.find<HomeController>().selectedTab.value = 0;
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