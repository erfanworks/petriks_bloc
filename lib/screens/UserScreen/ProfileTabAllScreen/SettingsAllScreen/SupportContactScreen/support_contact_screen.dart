import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../Widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import 'Controller/support_contact_controller.dart';

class SupportContactScreen extends StatelessWidget {
  const SupportContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SupportContactController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.supportContactHelp),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.subject,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEDF2),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: ConstColor.borderColor)
              ),
              child: TextField(
                controller: c.subjectController,
                style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  hintText: ConstString.subjectHint,
                  hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.grey),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            CustomText(
              title: ConstString.description,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 220.h,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextField(
                controller: c.descriptionController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: ConstString.descriptionHint,
                  hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.grey),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: EdgeInsets.only(bottom: 16.h + MediaQuery.of(context).padding.bottom),
              child: Obx(
                () => CustomElevatedButton(
                  onPressed: c.isSubmitting.value ? null : c.onSubmit,
                  height: 48,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: c.isFormValid.value && !c.isSubmitting.value
                      ? const [ConstColor.primaryDeepColor, ConstColor.primaryColor]
                      : [Colors.grey.shade400, Colors.grey.shade400],
                  child: c.isSubmitting.value
                      ? SizedBox(
                          width: 23.w,
                          height: 23.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : CustomText(
                          title: ConstString.submit,
                          textColor: Colors.white,
                          textSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}