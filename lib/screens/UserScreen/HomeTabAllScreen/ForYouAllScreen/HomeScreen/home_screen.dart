import 'dart:ui' as BorderType;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/home_controller.dart';
import 'Widget/easy_meetup_card.dart';
import 'Widget/featured_event_card.dart';
import 'Widget/people_card.dart';
import 'Widget/upcoming_event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: GlobalAppBar(
        showBack: false,
        leadingWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/app_logo.png",
            width: 22.w,
            height: 29.h,
            ),
            SizedBox(width: 6.w),
            CustomText(
              title: ConstString.appName,
              textColor: ConstColor.black,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            'assets/icons/notification_icon.svg',
            width: 22.w,
            height: 22.h,
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(
            'assets/icons/settings_icon.svg',
            width: 22.w,
            height: 22.h,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // ---- Search Bar ----
            _SearchBar(controller: controller),

            SizedBox(height: 14.h),

            // ---- Tab Bar ----
            _TabRow(controller: controller),

            SizedBox(height: 16.h),

            // ---- Featured Event Card ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const FeaturedEventCard(),
            ),

            SizedBox(height: 12.h),

            // ---- Invite Friends ----
            _InviteFriendsButton(controller: controller),

            SizedBox(height: 20.h),

            // ---- Easy Meetup Section ----
            _SectionHeader(
              title: ConstString.easyMeetup,
              showSeeAll: false,
            ),

            SizedBox(height: 12.h),

            SizedBox(
              height: 130.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.meetups.length,
                separatorBuilder: (_, _) => SizedBox(width: 12.w),
                itemBuilder: (_, index) =>
                    EasyMeetupCard(item: controller.meetups[index]),
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Upcoming Events ----
            _SectionHeader(
              title: ConstString.upcomingEvents,
              showSeeAll: true,
              onSeeAll: controller.onSeeAllEvents,
            ),

            SizedBox(height: 12.h),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.upcomingEvents.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (_, index) =>
                  UpcomingEventCard(item: controller.upcomingEvents[index]),
            ),

            SizedBox(height: 24.h),

            // ---- People You May Click With ----
            _SectionHeader(
              title: ConstString.peopleYouMayClick,
              showSeeAll: true,
              onSeeAll: controller.onSeeAllPeople,
            ),

            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                    () => Row(
                  children: controller.people
                      .map((p) => Expanded(child: PeopleCard(item: p)))
                      .toList(),
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

// ---- Search Bar ----
class _SearchBar extends StatelessWidget {
  final HomeController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Row(
                children: [
                  SizedBox(width: 12.w),
                  Icon(Icons.search, color: ConstColor.grey, size: 20.sp),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: ConstString.searchHint,
                    textColor: ConstColor.silverGray20,
                    textSize: 13.sp,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.tune, color: ConstColor.black, size: 20.sp),
          ),
        ],
      ),
    );
  }
}

// ---- Tab Row ----
class _TabRow extends StatelessWidget {
  final HomeController controller;

  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: List.generate(
            controller.tabs.length,
                (index) {
              final isSelected = controller.selectedTab.value == index;
              return GestureDetector(
                onTap: () => controller.selectedTab.value = index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ConstColor.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    title: controller.tabs[index],
                    textColor: isSelected ? Colors.white : ConstColor.textColor,
                    textSize: 14.sp,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    maxLine: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ---- Invite Friends Button ----
class _InviteFriendsButton extends StatelessWidget {
  final HomeController controller;

  const _InviteFriendsButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: controller.onInviteFriends,

        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: ConstColor.primaryDeepColor,
            strokeWidth: 1.2,
            dashPattern: const [10, 5],
            radius: Radius.circular(32.r),
            padding: EdgeInsets.zero,
          ),

          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_alt_1_outlined,
                  color: ConstColor.primaryColor,
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  title: ConstString.inviteFriends,
                  textColor: ConstColor.primaryColor,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---- Section Header ----
class _SectionHeader extends StatelessWidget {
  final String title;
  final bool showSeeAll;
  final VoidCallback? onSeeAll;

  const _SectionHeader({
    required this.title,
    this.showSeeAll = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: title,
            textColor: ConstColor.black,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
          if (showSeeAll)
            GestureDetector(
              onTap: onSeeAll,
              child: CustomText(
                title: ConstString.seeAll,
                textColor: ConstColor.primaryColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
            ),
        ],
      ),
    );
  }
}