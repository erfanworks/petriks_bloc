import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';

import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';

class PlanFeature {
  final String label;
  const PlanFeature(this.label);
}

class SubscriptionController extends GetxController {
  final selectedTab = 0.obs; // 0 = Monthly, 1 = Yearly

  final freeFeatures = const <PlanFeature>[
    PlanFeature(ConstString.freeFeature1),
    PlanFeature(ConstString.freeFeature2),
    PlanFeature(ConstString.freeFeature3),
    PlanFeature(ConstString.freeFeature4),
    PlanFeature(ConstString.freeFeature5),
    PlanFeature(ConstString.freeFeature6),
    PlanFeature(ConstString.freeFeature7),
    PlanFeature(ConstString.freeFeature8),
    PlanFeature(ConstString.freeFeature9),
    PlanFeature(ConstString.freeFeature10),
    PlanFeature(ConstString.freeFeature11),
  ];

  final premiumFeatures = const <PlanFeature>[
    PlanFeature(ConstString.premiumFeature1),
    PlanFeature(ConstString.premiumFeature2),
    PlanFeature(ConstString.premiumFeature3),
    PlanFeature(ConstString.premiumFeature4),
    PlanFeature(ConstString.premiumFeature5),
    PlanFeature(ConstString.premiumFeature6),
    PlanFeature(ConstString.premiumFeature7),
    PlanFeature(ConstString.premiumFeature8),
    PlanFeature(ConstString.premiumFeature9),
    PlanFeature(ConstString.premiumFeature10),
    PlanFeature(ConstString.premiumFeature11),
    PlanFeature(ConstString.premiumFeature12),
    PlanFeature(ConstString.premiumFeature13),
    PlanFeature(ConstString.premiumFeature14),
    PlanFeature(ConstString.premiumFeature15),
    PlanFeature(ConstString.premiumFeature16),
    PlanFeature(ConstString.premiumFeature17),
    PlanFeature(ConstString.premiumFeature18),
    PlanFeature(ConstString.premiumFeature19),
  ];

  String get priceLabel  => selectedTab.value == 0 ? ConstString.monthlyPrice  : ConstString.yearlyPrice;
  String get periodLabel => selectedTab.value == 0 ? ConstString.perMonth : ConstString.perYear;

  void onTabChanged(int index) => selectedTab.value = index;
  void onJoinFree() => Get.offAllNamed(AppRoutes.navBar);

  void onUpgradePremium() => AppSnackBar.message(
    "Feature Update! \nThis feature will be available soon.",
    backgroundColor: ConstColor.primaryColor,
  ); // TODO
}