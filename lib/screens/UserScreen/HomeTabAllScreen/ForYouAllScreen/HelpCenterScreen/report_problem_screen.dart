import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../PlanDetailsScreen/Controller/plan_details_controller.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.reportProblem),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.whyReporting,
              textColor: ConstColor.textColor,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            SizedBox(height: 12.h),

            // ---- Reasons ----
            ...controller.reportReasons.map(
                  (reason) => Obx(
                    () => GestureDetector(
                  onTap: () => controller.selectReason(reason),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title: reason.label,
                          textColor: ConstColor.grey,
                          textSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: reason.isSelected.value
                                  ? ConstColor.primaryColor
                                  : ConstColor.grey,
                              width: 1.5.w,
                            ),
                            color: reason.isSelected.value
                                ? ConstColor.primaryColor
                                : Colors.transparent,
                          ),
                          child: reason.isSelected.value
                              ? Icon(Icons.check_rounded, color: Colors.white, size: 12.sp)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Urgency ----
            CustomText(
              title: ConstString.urgencyLevel,
              textColor: ConstColor.black,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            SizedBox(height: 10.h),
            Obx(
                  () => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedUrgency.value,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: controller.urgencyLevels
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedUrgency.value = val;
                  },
                ),
              ),
            ),

            const Spacer(),

            CustomElevatedButton(
              onPressed: controller.submitReport,
              height: 50,
              top: 0,
              buttonBorderRadius: 30,
              gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
              child: CustomText(
                title: ConstString.submitReport,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}