import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Controller/one_to_one_meetup_controller.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Widget/one_to_one_meetup_card.dart';
import 'Controller/for_you_controller.dart';
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

          _SectionHeader(title: ConstString.easyMeetup, showSeeAll: false),

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

          SizedBox(height: 20.h),
          _SectionHeader(
            title: ConstString.peopleYouMayClick,
            showSeeAll: false,
            onSeeAll: controller.onSeeAllPeople,
          ),

          SizedBox(height: 12.h),
          SizedBox(
            height: 240.h,
            child: Obx(
                  () => ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w, right: 22.w),
                itemCount: controller.people.length,
                separatorBuilder: (_, _) => SizedBox(width: 5.w),
                itemBuilder: (_, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: PeopleCard(
                      item: controller.people[index],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24.h),

          _SectionHeader(
            title: ConstString.upcomingEvents,
            showSeeAll: false,
            onSeeAll: controller.onSeeAllEvents,
          ),

          SizedBox(height: 12.h),

          SizedBox(
            height: 440.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.w, right: 32.w),
              itemCount: controller.upcomingEvents.length,
              separatorBuilder: (_, _) => SizedBox(width: 12.w),
              itemBuilder: (_, index) => SizedBox(
                width: MediaQuery.of(context).size.width - 60.w,
                child: UpcomingEventCard(
                  item: controller.upcomingEvents[index],
                ),
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

  // ── Deep link / invite link ──
  static const _inviteLink = 'https://goodniva.app/invite?ref=USER_REF_CODE';
  static const _inviteText =
      'Join me on GoodNiva — discover local meetups & events! 🎉\n$_inviteLink';

  Future<void> _onTap(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(
        text: _inviteText,
        subject: 'Join GoodNiva!',
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: ConstColor.primaryColor.withAlpha(50)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                color: ConstColor.primaryColor,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              CustomText(
                title: ConstString.inviteFriendsBoots,
                textColor: ConstColor.primaryColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
              SizedBox(width: 10.w),
              Image.asset("assets/images/bossts_img.png"),
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
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
        ],
      ),
    );
  }
}
