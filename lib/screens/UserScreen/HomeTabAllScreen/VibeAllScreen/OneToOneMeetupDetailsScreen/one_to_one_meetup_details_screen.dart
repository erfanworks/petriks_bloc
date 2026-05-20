import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/VibeAllScreen/OneToOneMeetupDetailsScreen/Controller/one_to_one_meetup_details_controller.dart'
    hide PlanDetailsController;

import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';

class OneToOneMeetupDetailsScreen extends StatelessWidget {
  const OneToOneMeetupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OneToOneMeetupDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.planDetails),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AppImage(
                    path: 'assets/images/party_place_img.jpg',
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 150.h,
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
                              ),
                              _PillBadge(
                                label: ConstString.freeEntry,
                                bgColor: const Color(0xFFEDE9FF),
                                textColor: ConstColor.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          _DetailRow(
                            icon: Icons.location_on_outlined,
                            label: 'Central Park West, NYC',
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
                              _PillBadge(
                                label: '👥 Chill Vibe',
                                bgColor: const Color(0xFFEDE9FF),
                                textColor: ConstColor.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  width: 14.w,
                                  height: 14.h,
                                  "assets/icons/male_icon.svg"),
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
                          _DetailRow(
                            icon: Icons.language_rounded,
                            label: 'English',
                          ),
                          SizedBox(height: 6.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 170.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(() => CustomText(
                  title: controller.isLocked
                      ? '🕐 Time Confirmed!'
                      : 'Choose Time',
                  textColor: controller.isLocked
                      ? ConstColor.primaryColor
                      : ConstColor.black,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                )),
              ),
              SizedBox(height: 10.h),

              Obx(
                    () => controller.isLocked
                    ? _ChooseTimeCard(
                  timeText: 'Sat • 7:30 PM',
                  voteCount: '4 Vote',
                  isSelected: true,
                  onTap: () {},
                )
                    : Column(
                  children: [
                    _ChooseTimeCard(
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
                    _ChooseTimeCard(
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
                child: Obx(() => CustomText(
                  title: controller.isLocked
                      ? '📍 Venue Decided!'
                      : ConstString.pickALocation,
                  textColor: controller.isLocked
                      ? ConstColor.primaryColor
                      : ConstColor.black,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                )),
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
              // SizedBox(height: 20.h),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: CustomText(
              //     title: ConstString.location,
              //     textColor: ConstColor.black,
              //     textSize: 16.sp,
              //     fontWeight: FontWeight.w700,
              //     maxLine: 1,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(14.r),
              //     child: Stack(
              //       children: [
              //         Container(
              //           height: 160.h,
              //           width: double.infinity,
              //           color: const Color(0xFFE8E0D5),
              //           child: Image.asset(
              //             "assets/images/map_img.png",
              //             width: double.infinity,
              //             height: double.infinity,
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //         // Location pin
              //         Positioned(
              //           top: 55.h,
              //           left: 140.h,
              //
              //           child: Container(
              //             width: 32.r,
              //             height: 46.r,
              //             decoration: BoxDecoration(
              //               color: ConstColor.primaryColor,
              //               shape: BoxShape.circle,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withAlpha(125),
              //                   blurRadius: 6.r,
              //                 ),
              //               ],
              //             ),
              //             child: Center(
              //               child: SvgPicture.asset(
              //                 'assets/icons/location_icon.svg',
              //                 width: 18.r,
              //                 height: 18.r,
              //                 colorFilter: ColorFilter.mode(
              //                   ConstColor.white,
              //                   BlendMode.srcIn,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         // GPS button
              //         Positioned(
              //           right: 10.w,
              //           bottom: 30.h,
              //           child: Container(
              //             width: 36.r,
              //             height: 36.r,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               shape: BoxShape.circle,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withAlpha(25),
              //                   blurRadius: 6.r,
              //                 ),
              //               ],
              //             ),
              //             child: Center(
              //               child: SvgPicture.asset(
              //                 'assets/icons/location_pin.svg',
              //                 width: 18.r,
              //                 height: 18.r,
              //                 colorFilter: ColorFilter.mode(
              //                   ConstColor.primaryColor,
              //                   BlendMode.srcIn,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // SizedBox(height: 10.h),
              //
              // // ---- Group Chat ----
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(
              //         title: ConstString.group,
              //         textColor: ConstColor.black,
              //         textSize: 16.sp,
              //         fontWeight: FontWeight.w700,
              //         maxLine: 1,
              //       ),
              //       if (controller.hasJoined.value)
              //         GestureDetector(
              //           onTap: () {},
              //           child: CustomText(
              //             title: ConstString.view,
              //             textColor: ConstColor.primaryColor,
              //             textSize: 13.sp,
              //             fontWeight: FontWeight.w600,
              //             maxLine: 1,
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 10.h),
              //
              // // Chat locked or unlocked
              // controller.hasJoined.value
              //     ? _ChatUnlocked(controller: controller)
              //     : _ChatLocked(),

              SizedBox(height: 16.h),

              // ---- Host Profile ----
              _HostCard(),

              SizedBox(height: 12.h),

              // ---- Safety First ----
              _SafetyCard(),

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
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                if (!controller.isTimerExpired) {
                  return const SizedBox.shrink();
                }
                return AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Row(
                    children: [
                      if (!controller.hasNavigated.value) ...[
                        Expanded(
                          child: _OutlineButton(
                            label: ConstString.couldTAttend,
                            color: const Color(0xFFBA1A1A),
                            onTap: () {
                              Get.toNamed(AppRoutes.joinedPlanUserReport);
                              AppSnackBar.message("Attendance canceled");
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                      ],

                      Obx(
                            () => Expanded(
                          child: controller.hasNavigated.value
                              ? _OutlineButton(
                            label: ConstString.attendance,
                            color: const Color(0xFF006C49),
                            onTap: controller.onConfirmAttendance,
                          )
                              : _OutlineButton(
                            label: ConstString.navigate,
                            color: const Color(0xFF0077CC),
                            onTap: () => Get.toNamed(
                              AppRoutes.planMapScreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              CustomElevatedButton(
                height: 40.h,
                buttonBorderRadius: 32,
                gradient: [
                  ConstColor.primaryDeepColor,
                  ConstColor.primaryColor,
                ],
                onPressed: () {
                  Get.toNamed(AppRoutes.planChatScreen);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 18.sp,
                      color: ConstColor.white,
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      title: ConstString.openChat,
                      textColor: ConstColor.white,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
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

class _ChatLocked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.borderColor, width: 1.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Blurred background content ──
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
                child: Column(
                  children: [
                    // Fake blurred chat rows
                    _FakeBlurRow(width: 0.7),
                    SizedBox(height: 10.h),
                    _FakeBlurRow(width: 0.5),
                    SizedBox(height: 10.h),
                    _FakeBlurRow(width: 0.6),
                  ],
                ),
              ),
            ),
          ),

          // ── Lock overlay ──
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lock icon circle
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 22.sp,
                    color: ConstColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10.h),

                // Purple glow behind text
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        title: ConstString.joinToUnlock,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: ConstString.interactWith,
                        textColor: ConstColor.black,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        maxLine: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Fake blurred chat bubble row ──
class _FakeBlurRow extends StatelessWidget {
  const _FakeBlurRow({required this.width});

  final double width; // 0.0 to 1.0 fraction of screen width

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar circle
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor.withAlpha(60),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        // Chat bubble
        Container(
          height: 20.h,
          width: MediaQuery.of(context).size.width * width - 80.w,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor.withAlpha(40),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );
  }
}

// ---- Chat Unlocked ----
class _ChatUnlocked extends StatelessWidget {
  final OneToOneMeetupDetailsController controller;

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
            // ── My message: bubble left, avatar right ──
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
                  // Avatar right side
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

          // ── Other message: no avatar, name top-left, time bottom-right ──
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

// ---- Host Card ----
class _HostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ConstColor.borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          ClipOval(
            child: AppImage(
              path: 'assets/images/onboarding1_img.jpg',
              width: 44.w,
              height: 44.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'Marcus Chen',
                  textColor: ConstColor.black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: '⭐ Central Park West, NYC',
                  textColor: ConstColor.grey,
                  textSize: 12.sp,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.hostProfileScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: ConstColor.primaryColor),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                title: ConstString.viewProfile,
                textColor: ConstColor.primaryColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Safety Card ----
class _SafetyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDFF),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ConstColor.borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                size: 16.sp,
                color: ConstColor.primaryColor,
              ),
              SizedBox(width: 6.w),
              CustomText(
                title: ConstString.safetyFirst,
                textColor: ConstColor.primaryColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          CustomText(
            title: ConstString.verifyUserOnly,
            textColor: ConstColor.grey,
            textSize: 12.sp,
            maxLine: 4,
          ),
        ],
      ),
    );
  }
}

// ---- Shared Widgets ----
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: ConstColor.primaryDeepColor),
        SizedBox(width: 6.w),
        Flexible(
          child: CustomText(
            title: label,
            textColor: ConstColor.textColor,
            textSize: 12.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ),
      ],
    );
  }
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _PillBadge({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ConstColor.primaryDeepColor.withAlpha(40),
          width: 1.5,
        ),
      ),
      child: CustomText(
        title: label,
        textColor: textColor,
        textSize: 12.sp,
        fontWeight: FontWeight.w600,
        maxLine: 1,
      ),
    );
  }
}

class _SmallAvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.w,
      height: 26.h,
      child: Stack(
        children: [
          // Avatar 1
          Positioned(
            left: 0,
            child: _CircleAvatar(path: 'assets/images/onboarding5_img.jpg'),
          ),
          // Avatar 2
          Positioned(
            left: 15.w,
            child: _CircleAvatar(path: 'assets/images/onboarding3_img.jpg'),
          ),
          // +1 count badge
          Positioned(
            left: 30.w,
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ConstColor.primaryColor,
                border: Border.all(color: Colors.white, width: 1.5.w),
              ),
              child: Center(
                child: CustomText(
                  title: '+1',
                  textColor: Colors.white,
                  textSize: 9.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  final String path;

  const _CircleAvatar({required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5.w),
      ),
      child: ClipOval(
        child: AppImage(
          path: path,
          width: 26.w,
          height: 26.h,
          fit: BoxFit.cover,
        ),
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

class _ChooseTimeCard extends StatelessWidget {
  final String timeText;
  final String voteCount;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChooseTimeCard({
    required this.timeText,
    required this.voteCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ConstColor.primaryColor.withAlpha(15)
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? Border.all(color: ConstColor.primaryColor, width: 1.5.w)
              : Border.all(color: Colors.transparent, width: 1.5.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFF6F5FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: ConstColor.primaryColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: timeText,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: voteCount,
                  textColor: ConstColor.grey,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),

            const Spacer(),

            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: ConstColor.primaryColor,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
class _LocationVoteCard extends StatelessWidget {
  final LocationVoteItem item;
  final VoidCallback? onTap;

  const _LocationVoteCard({required this.item,this.onTap,});

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
                      _SmallAvatarStack(),
                      SizedBox(width: 8.w),
                      CustomText(
                        title: '${item.votes} votes',
                        textColor: ConstColor.grey,
                        textSize: 11.sp,
                        maxLine: 1,
                      ),
                      if (item.isSelected) ...[
                        SizedBox(width: 8.w),
                        const _PillBadge(
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
