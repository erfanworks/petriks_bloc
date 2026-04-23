import 'package:flutter/material.dart';import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../CommunityDetailScreen/Controller/community_detail_controller.dart';
import 'Widget/join_success_sheet.dart';

class JoinGroupScreen extends StatelessWidget {
  const JoinGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CommunityDetailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.joinAGroup),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
            child: CustomText(
              title: ConstString.selectGroups,
              textColor: ConstColor.black,
              textSize: 20.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.chooseGroupParticipate,
              textColor: ConstColor.textColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Obx(
                  () => ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: c.joinableGroups.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, i) {
                  final group = c.joinableGroups[i];
                  return Obx(
                        () => GestureDetector(
                      onTap: () => c.selectGroup(group),
                      child: Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: AppImage(
                                path: group.image,
                                width: 46.w,
                                height: 46.h,
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
                                    textSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    maxLine: 1,
                                  ),
                                  SizedBox(height: 2.h),
                                  CustomText(
                                    title: group.activeMembers,
                                    textColor: ConstColor.grey,
                                    fontWeight: FontWeight.w500,
                                    textSize: 10.sp,
                                    maxLine: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 22.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: group.isSelected.value
                                      ? ConstColor.primaryColor
                                      : ConstColor.grey,
                                  width: 2.w,
                                ),
                              ),
                              child: group.isSelected.value
                                  ? Center(
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ConstColor.primaryColor,
                                  ),
                                ),
                              )
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
          onPressed: () => JoinedSuccessDialog.show(
            context,
            communityName: 'Urban Athletes',
            onGoToChat: () => Get.toNamed('/community-chat'),
            onBackToDiscovery: () => Get.back(),
          ),
          height: 50,
          top: 0,
          buttonBorderRadius: 30,
          gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.confirm,
            textColor: Colors.white,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}