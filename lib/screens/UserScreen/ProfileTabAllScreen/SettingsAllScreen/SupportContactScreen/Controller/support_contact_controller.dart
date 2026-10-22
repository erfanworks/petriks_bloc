import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/Widget/SupportReportService/support_report_service.dart';
import '../../../../../../Widget/app_snack_bar/app_snack_bar.dart';

class SupportContactController extends GetxController {
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final isSubmitting = false.obs;
  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    subjectController.addListener(_validate);
    descriptionController.addListener(_validate);
  }

  void _validate() {
    isFormValid.value = subjectController.text.trim().isNotEmpty && 
                        descriptionController.text.trim().isNotEmpty;
  }

  Future<void> onSubmit() async {
    if (!isFormValid.value) {
      AppSnackBar.error("Please fill in both subject and description.");
      return;
    }
    final subject = subjectController.text.trim();
    final description = descriptionController.text.trim();
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isSubmitting.value = false;
    SupportReportService.to.add(subject: subject, description: description);
    Get.back();
    AppSnackBar.success("Your request has been submitted successfully.");
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
