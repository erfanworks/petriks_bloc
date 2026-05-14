import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../PlanDetailsScreen/Controller/plan_details_controller.dart';

class SupportHelpScreen extends StatelessWidget {
  const SupportHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.supportHelp),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              fromTitle: ConstString.subject,
              textController: controller.supportSubjectController,
              validator: (_) => null,
            ),
            SizedBox(height: 8.h),
          CustomText(
            title: ConstString.description,
            textColor: ConstColor.black,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),

          SizedBox(height: 8.h),

          Container(
            width: double.infinity,
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: ConstColor.borderColor,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: TextField(
              // controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                fontSize: 14.sp,
                color: ConstColor.textColor,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: "Type your description here...",
                hintStyle: TextStyle(
                  color: ConstColor.textColor.withAlpha(150),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                0.w,
                0,
                0.w,
                0.h + MediaQuery.of(context).padding.bottom,
              ),
              child: CustomElevatedButton(
                onPressed: controller.submitSupport,
                height: 50,
                top: 0,
                buttonBorderRadius: 30,
                gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
                child: CustomText(
                  title: ConstString.submit,
                  textColor: Colors.white,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}