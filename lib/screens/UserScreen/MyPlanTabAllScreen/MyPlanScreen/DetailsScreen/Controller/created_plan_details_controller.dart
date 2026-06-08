import 'package:get/get.dart';
import '../../Controller/my_plan_controller.dart';

class CreatedPlanDetailsController extends GetxController {
  PlanModel? plan;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is PlanModel) {
      plan = Get.arguments;
    }
  }
}
