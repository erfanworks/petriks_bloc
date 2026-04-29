import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Controller/one_to_one_meetup_controller.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Widget/one_to_one_meetup_card.dart';
import 'Controller/for_you_controller.dart';
import 'Widget/easy_meetup_card.dart';
import 'Widget/featured_event_card.dart';
import 'Widget/people_card.dart';
import 'Widget/upcoming_event_card.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForYouController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const FeaturedEventCard(),
          ),

          SizedBox(height: 12.h),

          _InviteFriendsButton(controller: controller),

          SizedBox(height: 20.h),

          _SectionHeader(title: ConstString.easyMeetup, showSeeAll: true),

          SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: Get.find<OneToOneMeetupController>().meetups.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (_, index) => OneToOneMeetupCard(
              item: Get.find<OneToOneMeetupController>().meetups[index],
            ),
          ),

          // SizedBox(
          //   height: 130.h,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.symmetric(horizontal: 16.w),
          //     itemCount: controller.meetups.length,
          //     separatorBuilder: (_, __) => SizedBox(width: 12.w),
          //     itemBuilder: (_, index) =>
          //         EasyMeetupCard(item: controller.meetups[index]),
          //   ),
          // ),
          SizedBox(height: 20.h),
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
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (_, index) =>
                UpcomingEventCard(item: controller.upcomingEvents[index]),
          ),

          SizedBox(height: 24.h),

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
    );
  }
}

class _InviteFriendsButton extends StatelessWidget {
  final ForYouController controller;

  const _InviteFriendsButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: (){
          Get.toNamed(AppRoutes.inviteFriendsListScreen);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: ConstColor.primaryColor.withAlpha(50))
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
    );
  }
}

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
