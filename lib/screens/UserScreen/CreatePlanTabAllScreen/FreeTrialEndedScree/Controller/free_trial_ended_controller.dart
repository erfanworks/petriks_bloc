import 'dart:ui';

import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

class TrialPlan {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  const TrialPlan({required this.title, required this.subtitle, required this.price, required this.period});
}

class FreeTrialEndedController extends GetxController {
  final selectedPlan = Rxn<int>();
  VoidCallback? onConfirmCallback;

  final plans = const [
    TrialPlan(title: 'GoodNiva Plus', subtitle: 'Full plus access',      price: 'GBP  €15',   period: '/ month'),
    TrialPlan(title: 'Create 1 Plan', subtitle: 'Allows user to create 1 plan', price: 'GBP  €1.49', period: ''),
  ];

  final features = const [
    'Unlimited Plan Joins',     'Create Plans',
    'Join Communities',         'Create Communities',
    'Join Competitions',        'Create Competitions',
    'Manage Teams',             'Create Recurring Activities',
    'Community Admin Tools',    'Advanced Filters',
    'Saved Vibe Preferences',   'Better Reminders',
    'Safety Tools',             'Block/reports',
    'Optional Partner Venue Suggestions',
  ];

  bool get canConfirm => selectedPlan.value != null;

  void selectPlan(int index) => selectedPlan.value = index;

  @override
  void onInit() {
    super.onInit();
    onConfirmCallback = Get.arguments?['onConfirm'];
  }

  void onConfirm() {
    if (!canConfirm) return;
    Get.back();
    onConfirmCallback?.call();
  }

  void onMaybeLater() => Get.back();
}