import 'package:get/get.dart';
import '../../../../../../widget/JoinedParticipantsSheet/joined_participants_sheet.dart';
import '../../Controller/my_plan_controller.dart';

class CreatedPlanDetailsController extends GetxController {
  PlanModel? plan;

  // TODO(API): API থেকে joined user আসলে এই list বদলে দেবেন
  final List<JoinedParticipant> joinedParticipants = const [
    JoinedParticipant(name: 'Sarah Lee', image: 'assets/images/person1_img.jpg'),
    JoinedParticipant(name: 'James Carter', image: 'assets/images/onboarding5_img.jpg'),
    JoinedParticipant(name: 'Priya Patel', image: 'assets/images/onboarding3_img.jpg'),
  ];

  void showJoinedParticipants() {
    JoinedParticipantsSheet.show(
      participants: joinedParticipants,
      maxCount: 6,
    );
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is PlanModel) {
      plan = Get.arguments;
    }
  }
}
