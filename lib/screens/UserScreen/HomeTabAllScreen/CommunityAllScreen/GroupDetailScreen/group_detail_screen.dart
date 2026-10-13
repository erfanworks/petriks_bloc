import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';
import 'package:petriks_flutter_app/widget/GroupDetailWidgets/group_detail_widgets.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../CommunityDetailScreen/Controller/community_detail_controller.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CommunityDetailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.groupDetails),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const GroupHeaderWidget(),
            SizedBox(height: 16.h),
            const GroupAboutCard(),
            SizedBox(height: 12.h),
            const GroupProgressCard(),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.competitions,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
            SizedBox(height: 10.h),
            ...c.competitions.map((comp) => _CompetitionListItem(item: comp)),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.fromLTRB(
            16.w, 0, 16.w,
            5.h + MediaQuery.of(context).padding.bottom,
          ),
          child: c.showUpgradeGate.value
              ? CustomElevatedButton(
                  onPressed: () => Get.toNamed(
                    AppRoutes.subscriptionScreen,
                    arguments: {
                      'onConfirm': () => c.showUpgradeGate.value = false,
                    },
                  ),
                  height: 50,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
                  child: CustomText(
                    title: ConstString.upgradeToPlusPrice,
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                )
              : CustomElevatedButton(
                  onPressed: c.onJoinCommunity,
                  height: 50,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
                  child: CustomText(
                    title: ConstString.joinGroup,
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
        ),
      ),
    );
  }
}

class _CompetitionListItem extends StatelessWidget {
  final CompetitionItem item;

  const _CompetitionListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { Get.toNamed(AppRoutes.viewCompetitionScreen); },
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: const BoxDecoration(
                color: Color(0xFFEDE9FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(item.emoji, style: TextStyle(fontSize: 20.sp)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.title,
                    textColor: ConstColor.black,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Container(
                        width: 7.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.isUpcoming
                              ? ConstColor.primaryColor
                              : Colors.red,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      CustomText(
                        title: item.status,
                        textColor: ConstColor.grey,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: ConstColor.grey,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
