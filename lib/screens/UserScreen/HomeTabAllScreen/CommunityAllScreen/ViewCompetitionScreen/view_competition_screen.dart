import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/widget/AppImage/app_image.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/view_competition_controller.dart';
import 'Widget/logistics_card.dart';
import 'Widget/roster_card.dart';

// 1 & 2. View Competition Screen (before + after register)
class ViewCompetitionScreen extends StatelessWidget {
  const ViewCompetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ViewCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.viewCompetition),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  title: ConstString.communityCompetitions,
                  textColor: ConstColor.black,
                  textSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),

              SizedBox(height: 12.h),

              _CompetitionBanner(),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  title: ConstString.eventLogistics,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),

              SizedBox(height: 10.h),

              LogisticsCard(),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  title: ConstString.pickALocation,
                  textColor: ConstColor.black,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
              SizedBox(height: 10.h),

              Column(
                children: [
                  ...c.locationVotes.map(
                    (loc) => _LocationVoteCard(
                      item: loc,
                      onTap: () {
                        c.selectLocation(loc);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: ConstString.groupChat,
                      textColor: ConstColor.black,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                    if (c.isRegistered.value)
                      GestureDetector(
                        onTap: c.onChat,
                        child: CustomText(
                          title: ConstString.view,
                          textColor: ConstColor.primaryColor,
                          textSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              c.isRegistered.value
                  ? _ChatUnlocked(controller: c)
                  : const _ChatLocked(),

              SizedBox(height: 16.h),

              _MatchNotesCard(),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  title: ConstString.yourTeam,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),

              SizedBox(height: 10.h),

              RosterCard(
                group: c.rosterGroups[0],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          final bool isOwner = c.isOwner.value;
          final bool isRegistered = c.isRegistered.value;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              16.w,
              5,
              16.w,
              4.h + MediaQuery.of(context).padding.bottom,
            ),
            child: isOwner
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mark as completed
                      CustomElevatedButton(
                        onPressed: c.onMarkCompleted,
                        height: 48,
                        top: 0,
                        bottom: 10,
                        buttonBorderRadius: 30,
                        gradient: const [
                          ConstColor.primaryDeepColor,
                          ConstColor.primaryColor
                        ],
                        child: CustomText(
                          title: ConstString.markAsCompleted,
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
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomElevatedButton(
                        onPressed: isRegistered ? c.onNavigate : c.onRegister,
                        height: 48,
                        top: 0,
                        buttonBorderRadius: 30,
                        gradient: const [
                          ConstColor.primaryDeepColor,
                          ConstColor.primaryColor
                        ],
                        child: CustomText(
                          title: isRegistered
                              ? ConstString.navigate
                              : ConstString.registerForCompetition,
                          textColor: Colors.white,
                          textSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomElevatedButton(
                        onPressed: isRegistered ? c.onChat : () => Get.back(),
                        height: 48,
                        top: 0,
                        elevation: 0,
                        buttonBorderRadius: 30,
                        isOutLined: true,
                        outLineColour: ConstColor.grey,
                        child: CustomText(
                          title: isRegistered
                              ? ConstString.openChat
                              : ConstString.cancel,
                          textColor: ConstColor.black,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class _CompetitionBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), ConstColor.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: 'SUMMER SPRINT LEAGUE',
                    textColor: Colors.white.withAlpha(180),
                    textSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      title: 'Upcoming',
                      textColor: Colors.white,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomText(
                title: 'Runners vs Sprinters',
                textColor: Colors.white,
                textSize: 28.sp,
                fontWeight: FontWeight.w800,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _BannerInfo(label: 'DATE', value: 'Oct 24'),
                  Container(
                    width: 1.w,
                    height: 30.h,
                    color: Colors.white.withAlpha(60),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  _BannerInfo(label: 'VENUE', value: 'Central Plaza'),
                ],
              ),
            ],
          ),
          // Decorative circle
          Positioned(
            right: -10.w,
            bottom: -10.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerInfo extends StatelessWidget {
  final String label;
  final String value;

  const _BannerInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          textColor: Colors.white.withAlpha(160),
          textSize: 10.sp,
          fontWeight: FontWeight.w700,
          maxLine: 1,
        ),
        CustomText(
          title: value,
          textColor: Colors.white,
          textSize: 16.sp,
          fontWeight: FontWeight.w700,
          maxLine: 1,
        ),
      ],
    );
  }
}

// ---- Match Notes Card ----
class _MatchNotesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EDFF),
        border: Border.all(color: ConstColor.primaryColor.withAlpha(40), width: 1),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: 'Match Notes',
            textColor: ConstColor.primaryColor,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title:
                '"Friendly game between long-time rivals. Expected high intensity and mutual respect on the pitch."',
            textColor: ConstColor.primaryColor,
            textSize: 14.sp,
            maxLine: 5,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 12.sp,
                color: ConstColor.primaryColor,
              ),
              SizedBox(width: 4.w),
              CustomText(
                title: 'ORGANIZER NOTE',
                textColor: ConstColor.primaryColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                maxLine: 1,
              ),
            ],
          ),
        ],
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
                      _SmallAvatarStack(),
                      SizedBox(width: 8.w),
                      CustomText(
                        title: '${item.votes} votes',
                        textColor: ConstColor.grey,
                        textSize: 11.sp,
                        maxLine: 1,
                      ),
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

class _ChatLocked extends StatelessWidget {
  const _ChatLocked();

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
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
                child: Column(
                  children: [
                    const _FakeBlurRow(width: 0.7),
                    SizedBox(height: 10.h),
                    const _FakeBlurRow(width: 0.5),
                    SizedBox(height: 10.h),
                    const _FakeBlurRow(width: 0.6),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        offset: const Offset(0, 3),
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

class _FakeBlurRow extends StatelessWidget {
  const _FakeBlurRow({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            color: ConstColor.primaryColor.withAlpha(60),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
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

class _ChatUnlocked extends StatelessWidget {
  final ViewCompetitionController controller;

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

class _SmallAvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.w,
      height: 26.h,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            child: _CircleAvatar(path: 'assets/images/onboarding5_img.jpg'),
          ),
          Positioned(
            left: 15.w,
            child: const _CircleAvatar(
              path: 'assets/images/onboarding3_img.jpg',
            ),
          ),
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

