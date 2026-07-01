import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/constant/const_color.dart';

class BoostPackage {
  final String title;
  final String subtitle;
  final String price;
  const BoostPackage({required this.title, required this.subtitle, required this.price});
}

class BoostPlanController extends GetxController {
  final selectedPackage = 1.obs; // default: 3 Days selected (matches SS)

  final features = const [
    'Appear higher in Feed',
    'Show in Discovery',
    'Increase engagement',
    'Reach nearby users',
  ];

  // final packages = const [
  //   BoostPackage(title: '24 Hours', subtitle: 'Essential for short-term visibility', price: '£2.99'),
  //   BoostPackage(title: '3 Days',   subtitle: 'Optimal balance for events',          price: '£4.99'),
  //   BoostPackage(title: '7 days',   subtitle: 'Optimal balance for events',          price: '£9.99'),
  // ];

  void selectPackage(int index) => selectedPackage.value = index;

  void onConfirm() {
    Get.back();
    AppSnackBar.success("Your plan has been boosted! 🚀", seconds: 2);
  }
}