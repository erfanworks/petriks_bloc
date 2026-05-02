import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/view_competition_controller.dart';
import 'Widget/logistics_card.dart';
import 'Widget/roster_card.dart';
import 'Widget/vs_banner.dart';

class FinalScoreScreen extends StatelessWidget {
  const FinalScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ViewCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.viewCompetition),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.finalScore,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: VSBanner(showWinner: true),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.eventLogistics,
                textColor: ConstColor.black,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 10.h),
            LogisticsCard(),

            SizedBox(height: 16.h),
            _OwnerNoteCard(),
            SizedBox(height: 20.h),

            // ---- Teams Roster ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.teamsRoster,
                textColor: ConstColor.black,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 10.h),
            ...c.rosterGroups.map(
              (g) => RosterCard(
                group: g,
                memberLabel: g.memberCount.replaceAll(
                  'Registered',
                  'Participate',
                ),
              ),
            ),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
      //   child: CustomElevatedButton(
      //     onPressed: c.onEditResult,
      //     height: 48,
      //     elevation: 0,
      //     top: 0,
      //     buttonBorderRadius: 30,
      //     isOutLined: true,
      //     outLineColour: ConstColor.grey,
      //     icon: Icon(Icons.edit_outlined, size: 16.sp, color: ConstColor.black),
      //     child: CustomText(
      //       title: ConstString.editResult,
      //       textColor: ConstColor.black,
      //       textSize: 14.sp,
      //       fontWeight: FontWeight.w500,
      //       maxLine: 1,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
          child: c.isRegistered.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mark as completed
                    CustomElevatedButton(
                      onPressed: c.backToHome,
                      height: 48,
                      top: 0,
                      bottom: 10,
                      buttonBorderRadius: 30,
                      gradient: const [
                        ConstColor.primaryDeepColor,
                        ConstColor.primaryColor,
                      ],
                      child: CustomText(
                        title: ConstString.backToHome,
                        textColor: Colors.white,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                    // Edit competition
                    CustomElevatedButton(
                      onPressed: c.onEditCompetition,
                      height: 48,
                      top: 0,
                      elevation: 0,
                      buttonBorderRadius: 30,
                      isOutLined: true,
                      outLineColour: ConstColor.grey,
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 16.sp,
                        color: ConstColor.black,
                      ),
                      child: CustomText(
                        title: ConstString.editCompetition,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  ],
                )
              : CustomElevatedButton(
                  onPressed: c.onRegister,
                  height: 48,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: const [
                    ConstColor.primaryDeepColor,
                    ConstColor.primaryColor,
                  ],
                  child: CustomText(
                    title: ConstString.registerNow,
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

class _OwnerNoteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: AppImage(
                  path: 'assets/images/person1_img.jpg',
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'Community Owner Note',
                    textColor: ConstColor.primaryColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: 'Marcus Chen',
                    textColor: ConstColor.black,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ],
              ),
              const Spacer(),
              CustomText(
                title: '❞',
                textColor: ConstColor.grey.withAlpha(100),
                textSize: 34.sp,
                maxLine: 1,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CustomText(
            title:
                '"Incredible intensity from both sides today. Group A\'s defensive transition was the deciding factor in the second half. Big shoutout to everyone for keeping the energy high and respectful. See you at the next one!"',
            textColor: ConstColor.textColor,
            textSize: 12.sp,
            maxLine: 8,
            fontStyle: FontStyle.italic,
          ),
        ],
      ),
    );
  }
}
