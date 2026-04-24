import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_competition_controller.dart';

class ChooseGroupsScreen extends StatelessWidget {
  const ChooseGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.createCompetitions),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 4.h),
            child: CustomText(
              title: ConstString.chooseGroups,
              textColor: ConstColor.black,
              textSize: 24.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.selectTwoGroups,
              textColor: ConstColor.grey,
              textSize: 16.sp,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Obx(
                  () => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: c.groups.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (_, i) {
                  final group = c.groups[i];
                  return Obx(
                        () => GestureDetector(
                      onTap: () => c.toggleGroup(group),
                      child: Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: group.isSelected.value
                              ? Border.all(color: ConstColor.primaryColor, width: 1.5.w)
                              : Border.all(color: ConstColor.borderColor, width: 1.w),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: AppImage(
                                path: group.image,
                                width: 48.w,
                                height: 48.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: group.name,
                                    textColor: ConstColor.black,
                                    textSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 1,
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    children: [
                                      Icon(Icons.people_outline, size: 16.sp, color: ConstColor.primaryColor),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        title: group.memberCount,
                                        textColor: ConstColor.primaryColor,
                                        textSize: 14.sp,
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Checkbox
                            Container(
                              width: 24.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: group.isSelected.value
                                    ? ConstColor.primaryColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: group.isSelected.value
                                      ? ConstColor.primaryColor
                                      : ConstColor.borderColor,
                                  width: 1.5.w,
                                ),
                              ),
                              child: group.isSelected.value
                                  ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: CustomElevatedButton(
          onPressed: c.goToSelectActivity,
          height: 48, top: 0, buttonBorderRadius: 30,
          gradient: const [ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(title: ConstString.continueText, textColor: Colors.white, textSize: 15.sp, fontWeight: FontWeight.w600, maxLine: 1),
        ),
      ),
    );
  }
}
