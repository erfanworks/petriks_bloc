import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/MyPlanTabAllScreen/MyPlanScreen/my_plan_screen.dart';
import 'package:petriks_flutter_app/screens/UserScreen/ProfileTabAllScreen/ProfileScreen/profile_screen.dart';
import '../../../UserScreen/CreatePlanTabAllScreen/CreatePlanScreen/create_plan_screen.dart';
import '../../../UserScreen/HomeTabAllScreen/HomeScreen/home_screen.dart';
import '../../../UserScreen/MessageTabAllScreen/ChatScreen/chat_screen.dart';

class NavbarController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages =[
    const HomeScreen(),
    const MyPlanScreen(),
    const CreatePlanScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void onTabTap(int index) {
    if (index == 2) {
      Get.toNamed(AppRoutes.createPlanScreen);
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
