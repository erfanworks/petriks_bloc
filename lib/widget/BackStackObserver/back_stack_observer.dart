// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../routes/app_routes/app_routes.dart';
// import '../../screens/UserScreen/HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';
//
// class BackStackObserver extends NavigatorObserver {
//   int _pushCount = 0;
//   static const int _maxDepth = 3;
//
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     _pushCount++;
//   }
//
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _pushCount = (_pushCount - 1).clamp(0, 999);
//
//     if (_pushCount >= _maxDepth) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Get.offAllNamed(AppRoutes.navBar);
//         try {
//           Get.find<HomeController>().selectedTab.value = 0;
//         } catch (_) {}
//       });
//     }
//   }
// }