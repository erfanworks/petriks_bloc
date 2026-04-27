import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/widget/AppImage/app_image.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/connection_controller.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ConnectionController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.connection, showBack: true),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          _TabBar(c: c),
          SizedBox(height: 12.h),
          Expanded(
            child: Obx(() {
              final list = c.selectedTab.value == 0 ? c.followers : c.following;
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: list.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (_, i) => _UserTile(
                  user: list[i],
                  isFollowingTab: c.selectedTab.value == 1,
                  onTap: () => c.onFollowToggle(list[i]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final ConnectionController c;
  const _TabBar({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(color: ConstColor.white, borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          children: [
            _TabItem(label: ConstString.followersTab, isSelected: c.selectedTab.value == 0, onTap: () => c.onTabChanged(0)),
            _TabItem(label: ConstString.followingTab,  isSelected: c.selectedTab.value == 1, onTap: () => c.onTabChanged(1)),
          ],
        ),
      ),
    ));
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TabItem({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.white : Colors.transparent,
            borderRadius: BorderRadius.circular(26.r),
            boxShadow: isSelected ? [BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 6)] : [],
          ),
          child: Center(
            child: CustomText(
              title: label,
              textSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              textColor: isSelected ? ConstColor.primaryColor : ConstColor.grey,
              maxLine: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final ConnectionUser user;
  final bool isFollowingTab;
  final VoidCallback onTap;

  const _UserTile({
    required this.user,
    required this.isFollowingTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(color: ConstColor.white, borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: AppImage(path: user.image, width: 46.w, height: 46.h, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: user.name,     textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
                SizedBox(height: 2.h),
                CustomText(title: user.username, textSize: 12.sp, textColor: ConstColor.grey,  maxLine: 1),
              ],
            ),
          ),
          SizedBox(
            width: 96.w,
            height: 36.h,
            child: Obx(() {
              // ─── ERROR FIXED: Explicitly read the observable before short-circuit logic ───
              final bool isFollowing = user.isFollowing.value;

              final showFollowing = isFollowingTab || isFollowing;

              return CustomElevatedButton(
                onPressed: onTap,
                height: 36,
                width: 96,
                top: 0,
                buttonBorderRadius: 20,
                color: showFollowing ? ConstColor.boxColor : ConstColor.primaryColor,
                child: CustomText(
                  title: showFollowing ? ConstString.followingLabel : ConstString.follow,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  textColor: showFollowing ? ConstColor.grey : ConstColor.white,
                  maxLine: 1,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
