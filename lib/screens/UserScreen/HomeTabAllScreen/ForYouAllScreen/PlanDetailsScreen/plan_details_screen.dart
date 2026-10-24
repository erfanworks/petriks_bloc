import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/widget/AppDialog/app_confirm_dialog.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/ForYouAllScreen/PlanDetailsScreen/Controller/plan_details_controller.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/PlanDetailWidgets/plan_detail_widgets.dart';

class PlanDetailsScreen extends StatelessWidget {
  const PlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.initLockTimer(
    //     DateTime.now().add(const Duration(hours: 2, minutes: 30)),
    //   );
    // });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.planDetails),
      body: Obx(
            () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 345.h,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AppImage(
                      path: 'assets/images/party_place_img.jpg',
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),

                    Positioned(
                      top: 8.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: ConstColor.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/world_icon.svg"),
                            const SizedBox(width: 5),
                            CustomText(
                              title: ConstString.publicLabel,
                              textColor: ConstColor.primaryColor,
                              textSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 16.w,
                      right: 16.w,
                      child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 12,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: ConstString.hangOutPark,
                                textColor: ConstColor.black,
                                textSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                maxLine: 1,
                                fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                              ),
                              const PillBadge(
                                label: ConstString.freeEntry,
                                bgColor: Color(0xFFEDE9FF),
                                textColor: ConstColor.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          const PlanDetailRow(
                            icon: Icons.location_on_outlined,
                            label: 'Hyde Park, London',
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 13.sp,
                                color: ConstColor.primaryDeepColor,
                              ),
                              SizedBox(width: 6.w),
                              CustomText(
                                title: 'Saturday, 24 June',
                                textColor: ConstColor.textColor,
                                textSize: 12.sp,
                                maxLine: 1,
                              ),
                              SizedBox(width: 10.w),
                              const PillBadge(
                                label: '👥 Chill Vibe',
                                bgColor: Color(0xFFEDE9FF),
                                textColor: ConstColor.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          const PlanDetailRow(
                            icon: Icons.language_rounded,
                            label: 'English',
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              SvgPicture.asset(
                                width: 14.w,
                                height: 14.h,
                                "assets/icons/male_icon.svg",
                              ),
                              SizedBox(width: 6.w),
                              CustomText(
                                title: "Male (20-25)",
                                textColor: ConstColor.textColor,
                                textSize: 12.sp,
                                maxLine: 1,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          const PlanDetailRow(
                            icon: Icons.people_outline,
                            label: 'Group Plan',
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: controller.showJoinedParticipants,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SmallAvatarStack(),
                                    SizedBox(width: 8.w),
                                    CustomText(
                                      title: '3/6 JOINED',
                                      textColor: ConstColor.primaryColor,
                                      textSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      maxLine: 1,
                                      fontFamily:
                                          GoogleFonts.plusJakartaSans().fontFamily,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.inviteFriendsListScreen,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: ConstColor.borderColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.person_add_alt_1_outlined,
                                        size: 13.sp,
                                        color: ConstColor.primaryColor,
                                      ),
                                      SizedBox(width: 2.w),
                                      CustomText(
                                        title: ConstString.invite,
                                        textColor: ConstColor.primaryColor,
                                        textSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        maxLine: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

              SizedBox(height: 25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                      () => CustomText(
                    title: controller.isLocked
                        ? '🕐 Time Confirmed!'
                        : 'Choose Time',
                    textColor: controller.isLocked
                        ? ConstColor.black
                        : ConstColor.black,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Obx(
                    () => controller.isLocked
                    ? ChooseTimeCardWidget(
                  timeText: 'Sat • 7:30 PM',
                  voteCount: '4 Vote',
                  isSelected: true,
                  onTap: () {},
                )
                    : Column(
                  children: [
                    ChooseTimeCardWidget(
                      timeText: 'Sat • 7:30 PM',
                      voteCount: '4 Vote',
                      isSelected: controller.selectedTimeIndex.value == 0,
                      onTap: () {
                        if (!controller.hasJoined.value) {
                          AppSnackBar.message(
                            'Please join this plan to vote on time and location.',
                          );
                          return;
                        }
                        controller.selectTime(0);
                      },
                    ),
                    ChooseTimeCardWidget(
                      timeText: 'Sat • 8:40 PM',
                      voteCount: '2 Vote',
                      isSelected: controller.selectedTimeIndex.value == 1,
                      onTap: () {
                        if (!controller.hasJoined.value) {
                          AppSnackBar.message(
                            'Please join this plan to vote on time and location.',
                          );
                          return;
                        }
                        controller.selectTime(1);
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                      () => CustomText(
                    title: controller.isLocked
                        ? '📍 Venue Decided!'
                        : ConstString.pickALocation,
                    textColor: controller.isLocked
                        ? ConstColor.black
                        : ConstColor.black,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Obx(
                    () => controller.isLocked
                    ? _LocationVoteCard(
                  item: controller.locationVotes.reduce(
                        (a, b) => a.votes >= b.votes ? a : b,
                  ),
                )
                    : Column(
                  children: [
                    ...controller.locationVotes.map(
                          (loc) => _LocationVoteCard(
                        item: loc,
                        onTap: () {
                          if (!controller.hasJoined.value) {
                            AppSnackBar.message(
                              'Please join this plan to vote on time and location.',
                            );
                            return;
                          }
                          controller.selectLocation(loc);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: controller.lockTimer.value.isNotEmpty
                      ? ConstColor.primaryColor.withAlpha(20)
                      : const Color(0xFFBA1A1A).withAlpha(20),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.lockTimer.value.isNotEmpty
                        ? Icon(
                      Icons.hourglass_bottom_rounded,
                      color: ConstColor.primaryColor,
                      size: 16.r,
                    )
                        : SizedBox.shrink(),
                    SizedBox(width: 6.w),
                    Obx(
                          () => controller.lockTimer.value.isNotEmpty
                          ? CustomText(
                        title: 'Locks in: ${controller.lockTimer.value}',
                        textColor: ConstColor.primaryColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      )
                          : controller.lockUntil != null
                          ? CustomText(
                        title: 'Plan is now locked 🔒',
                        textColor: const Color(0xFFBA1A1A),
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: ConstString.planGroupChat,
                      textColor: ConstColor.black,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                    if (controller.hasJoined.value)
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.planChatScreen);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 18.sp,
                              color: ConstColor.primaryColor,
                            ),
                            SizedBox(width: 6.w),
                            CustomText(
                              title: ConstString.openChat,
                              textColor: ConstColor.primaryColor,
                              textSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              maxLine: 1,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              controller.hasJoined.value
                  ? _ChatUnlocked(controller: controller)
                  : const ChatLockedWidget(),

              SizedBox(height: 16.h),

              const HostCardWidget(),

              SizedBox(height: 12.h),

              const SafetyCardWidget(),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Obx(
            () => Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            4.h + MediaQuery.of(context).padding.bottom,
          ),
          child: controller.hasJoined.value
              ? controller.isLocked
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: _OutlineButton(
                      label: ConstString.couldTAttend,
                      color: const Color(0xFFBA1A1A),
                      onTap: () {
                        AppConfirmDialog.show(
                          title: "Couldn't Attend?",
                          message: "Are you sure you can't attend? You'll be asked to share a reason next.",
                          confirmText: "Yes, Continue",
                          icon: Icons.event_busy_rounded,
                          onConfirm: () {
                            Get.toNamed(AppRoutes.joinedPlanUserReport);
                            AppSnackBar.message("Attendance cancelled");
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _OutlineButton(
                      label: ConstString.attendance,
                      color: const Color(0xFF006C49),
                      onTap: controller.onConfirmAttendance,
                    ),
                  ),
                ],
              ),
              CustomElevatedButton(
                height: 48.h,
                top: 12,
                buttonBorderRadius: 32,
                gradient: [
                  ConstColor.primaryDeepColor,
                  ConstColor.primaryColor,
                ],
                onPressed: () => Get.toNamed(AppRoutes.planMapScreen),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.near_me_rounded,
                      size: 20.sp,
                      color: ConstColor.white,
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      title: ConstString.navigate,
                      textColor: ConstColor.white,
                      textSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          )
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ConstColor.primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: ConstColor.primaryColor, size: 20.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomText(
                        title: "You've joined! The plan will lock once the timer ends.",
                        textColor: ConstColor.primaryColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              _OutlineButton(
                label: "Leave Plan",
                color: Colors.grey.shade600,
                onTap: controller.leavePlan,
              ),
              SizedBox(height: 10.h),
            ],
          )
              : controller.showBoostGate.value
              ? CustomElevatedButton(
            onPressed: controller.showSelectPackageSheet,
            height: 50,
            top: 0,
            buttonBorderRadius: 30,
            gradient: const [
              ConstColor.primaryDeepColor,
              ConstColor.primaryColor,
            ],
            child: CustomText(
              title: ConstString.get1BoostToJoin,
              textColor: Colors.white,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          )
              : CustomElevatedButton(
            onPressed: controller.showJoinSheet,
            height: 50,
            top: 0,
            buttonBorderRadius: 30,
            gradient: const [
              ConstColor.primaryDeepColor,
              ConstColor.primaryColor,
            ],
            child: CustomText(
              title: ConstString.joinEvent,
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

class _LocationVoteCard extends StatelessWidget {
  final LocationVoteItem item;
  final VoidCallback? onTap;

  const _LocationVoteCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: item.isSelected
              ? Border.all(color: ConstColor.primaryColor, width: 1.5.w)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                  ),
                  child: AppImage(
                    path: item.image,
                    width: double.infinity,
                    height: 110.h,
                    fit: BoxFit.cover,
                  ),
                ),
                if (item.isSelected)
                  Positioned(
                    bottom: 8.h,
                    left: 10.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: 'Selected',
                            textColor: Colors.white,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: item.name,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      CustomText(
                        title: '${item.percent}%',
                        textColor: ConstColor.primaryColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SmallAvatarStack(),
                      SizedBox(width: 8.w),
                      CustomText(
                        title: '${item.votes} votes',
                        textColor: ConstColor.grey,
                        textSize: 11.sp,
                        maxLine: 1,
                      ),
                      if (item.isSelected) ...[
                        SizedBox(width: 8.w),
                        const PillBadge(
                          label: 'MOST VOTED',
                          bgColor: Color(0x336C5CE7),
                          textColor: ConstColor.primaryColor,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9.r),
                    child: LinearProgressIndicator(
                      value: item.votes / item.totalVotes,
                      minHeight: 5.h,
                      backgroundColor: const Color(0xFFEDE9FF),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        ConstColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatUnlocked extends StatelessWidget {
  final PlanDetailsController controller;

  const _ChatUnlocked({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: controller.chatMessages.map((msg) {
          if (msg.isMe) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h, left: 40.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: ConstColor.primaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CustomText(
                            title: msg.message,
                            textColor: Colors.white,
                            textSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 5,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomText(
                          title: msg.time,
                          textColor: ConstColor.grey,
                          textSize: 10.sp,
                          textAlign: TextAlign.right,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  ClipOval(
                    child: AppImage(
                      path: msg.avatar ?? 'assets/images/person1_img.jpg',
                      width: 32.r,
                      height: 32.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h, right: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: msg.senderName,
                  textColor: ConstColor.primaryColor,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5FA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CustomText(
                    title: msg.message,
                    textColor: ConstColor.black,
                    textSize: 14.sp,
                    maxLine: 5,
                  ),
                ),
                SizedBox(height: 2.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    title: msg.time,
                    textColor: ConstColor.grey,
                    textSize: 10.sp,
                    maxLine: 1,
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _OutlineButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: CustomText(
            title: label,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: color,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}