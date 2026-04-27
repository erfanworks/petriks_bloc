import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';

import '../../../../../routes/app_routes/app_routes.dart';

class PlanFeature {
  final String label;
  const PlanFeature(this.label);
}

class SubscriptionController extends GetxController {
  final selectedTab = 0.obs; // 0 = Monthly, 1 = Yearly

  final freeFeatures = const <PlanFeature>[
    PlanFeature('Join limited plans'),
    PlanFeature('Standard recommendations'),
    PlanFeature('Join communities & groups'),
    PlanFeature('Basic chat (community + group)'),
    PlanFeature('Join limited plans'),
    PlanFeature('Standard recommendations'),
    PlanFeature('Basic chat (community + group)'),
  ];

  final premiumFeatures = const <PlanFeature>[
    PlanFeature('Join unlimited plans'),
    PlanFeature("See who's going"),
    PlanFeature('Priority recommendations'),
    PlanFeature('Join unlimited plans'),
    PlanFeature('Early access to new features'),
    PlanFeature('Join unlimited plans'),
  ];

  String get priceLabel  => selectedTab.value == 0 ? '\$9.99'  : '\$79.99';
  String get periodLabel => selectedTab.value == 0 ? '/ month' : '/ year';

  void onTabChanged(int index) => selectedTab.value = index;
  void onJoinFree() => Get.offAllNamed(AppRoutes.navBar);

  void onUpgradePremium() => AppSnackBar.message("Feature Update! \nThis feature will be available soon.",backgroundColor: ConstColor.primaryColor); // TODO
}