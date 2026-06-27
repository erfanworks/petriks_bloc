import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityScreen/my_community_screen.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/community_controller.dart';
import 'Widget/community_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityController>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(controller.communityTabs.length, (i) {
                  final isSelected = controller.selectedCommunityTab.value == i;
                  return GestureDetector(
                    onTap: () => controller.selectedCommunityTab.value = i,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.w),
                      padding: EdgeInsets.only(bottom: 2.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? ConstColor.primaryColor
                                : Colors.transparent,
                            width: 2.h,
                          ),
                        ),
                      ),
                      child: CustomText(
                        title: controller.communityTabs[i],
                        textColor: isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.grey,
                        textSize: 14.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Expanded(
            child: Obx(() {
              if (controller.selectedCommunityTab.value == 0) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: controller.communities.length,
                        separatorBuilder: (_, _) => SizedBox(height: 16.h),
                        itemBuilder: (_, index) => CommunityCard(
                          item: controller.communities[index],
                          onTap: () => controller.onViewCommunity(
                            controller.communities[index],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomText(
                          title: ConstString.appNews,
                          textColor: ConstColor.black,
                          textSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      ...controller.appNews.map((news) => _AppNewsItem(item: news)),

                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              } else {
                return Obx(
                      () => controller.showUpgradeWall.value
                      ? _CommunityUpgradeWall(controller: controller)
                      : MyCommunityScreen(),
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => controller.selectedCommunityTab.value == 0
            ? Padding(
          padding: EdgeInsets.fromLTRB(
            16.w, 8.h, 16.w,
            8.h + MediaQuery.of(context).padding.bottom,
          ),
          child: CustomElevatedButton(
            onPressed: () => Get.toNamed(
              AppRoutes.freeTrialEndedScreen,
              arguments: {
                'onConfirm': () {},
              },
            ),
            height: 52,
            top: 0,
            buttonBorderRadius: 30,
            elevation: 0,
            gradient: const [
              ConstColor.primaryDeepColor,
              ConstColor.primaryColor,
            ],
            child: CustomText(
              title: ConstString.upgradeToPlusPrice,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
              maxLine: 1,
            ),
          ),
        )
            : const SizedBox.shrink(),
      ),
    );
  }
}

// community upgrade wall screen

class _CommunityUpgradeWall extends StatelessWidget {
  final CommunityController controller;

  const _CommunityUpgradeWall({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),

          // Title
          CustomText(
            title: ConstString.createYourOwnCommunity,
            textSize: 22.sp,
            fontWeight: FontWeight.w700,
            textColor: ConstColor.black,
            maxLine: 2,
            textAlign: TextAlign.center,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 16.h),

          // Subtitle
          CustomText(
            title: ConstString.createCommunitySubtitle,
            textSize: 16.sp,
            textColor: ConstColor.textColor,
            maxLine: 5,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 48.h),

          // Info card
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: ConstColor.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ConstColor.borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 10.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor.withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    color: ConstColor.primaryColor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: ConstString.communityCreationAvailable,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.primaryColor,
                        maxLine: 2,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: ConstString.communityCreationDesc,
                        textSize: 12.sp,
                        textColor: ConstColor.textColor,
                        maxLine: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Upgrade button
          GestureDetector(
            onTap: controller.onUpgradeTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: ConstColor.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.workspace_premium_rounded,
                  //   color: ConstColor.primaryColor,
                  //   size: 18.sp,
                  // ),
                  SvgPicture.asset("assets/icons/Upgrade.svg"),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: ConstString.upgradeToCreatePlans,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.primaryColor,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

// ---- App News Item ----
class _AppNewsItem extends StatelessWidget {
  final AppNewsItem item;

  const _AppNewsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xFFEDE9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(item.emoji, style: TextStyle(fontSize: 18.sp)),
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
                CustomText(
                  title: item.description,
                  textColor: ConstColor.grey,
                  textSize: 14.sp,
                  maxLine: 3,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: item.timeAgo,
                  textColor: ConstColor.primaryDeepColor,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
