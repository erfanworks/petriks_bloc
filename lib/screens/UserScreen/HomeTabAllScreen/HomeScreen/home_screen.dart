import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../CommunityAllScreen/CommunityScreen/community_screen.dart';
import '../FeedAllScreen/FeedScreen/feed_screen.dart';
import '../ForYouAllScreen/ForYouScreen/for_you_screen.dart';
import '../VibeAllScreen/VibeScreen/vibe_screen.dart';
import 'Controller/home_controller.dart';
import 'Widget/filter_sheet.dart';

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
            Image.asset(
              "assets/images/app_logo.png",
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
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.notificationScreen);
            },
            child: SvgPicture.asset(
              'assets/icons/notification_icon.svg',
              width: 22.w,
              height: 22.h,
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.settingsScreen);
            },
            child: SvgPicture.asset(
              'assets/icons/settings_icon.svg',
              width: 22.w,
              height: 22.h,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),

          _SearchBar(),

          SizedBox(height: 10.h),

          _TabRow(controller: controller),

          SizedBox(height: 4.h),

          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedTab.value,
                children: const [
                  ForYouScreen(),
                  VibeScreen(),
                  FeedScreen(),
                  CommunityScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

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
              child: TextField(
                style: TextStyle(
                  color: ConstColor.black,
                  fontSize: 13.sp,
                  fontFamily: 'Poppins',
                  decorationThickness: 0,
                ),
                cursorColor: ConstColor.primaryColor,
                decoration: InputDecoration(
                  hintText: ConstString.searchHint,
                  hintStyle: TextStyle(
                    color: ConstColor.silverGray20,
                    fontSize: 13.sp,
                    fontFamily: 'Poppins',
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: ConstColor.grey,
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
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
            child: InkWell(
              onTap: () => showFilterSheet(),
              child: Icon(Icons.tune, color: ConstColor.black, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabRow extends StatelessWidget {
  final HomeController controller;

  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Row(
          children: List.generate(controller.tabs.length, (index) {
            final isSelected = controller.selectedTab.value == index;
            return GestureDetector(
              onTap: () => controller.selectedTab.value = index,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected ? ConstColor.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  title: controller.tabs[index],
                  textColor: isSelected ? Colors.white : ConstColor.textColor,
                  textSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  maxLine: 1,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
