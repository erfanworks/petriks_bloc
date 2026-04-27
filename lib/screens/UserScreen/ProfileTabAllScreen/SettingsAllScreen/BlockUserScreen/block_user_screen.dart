import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/block_user_controller.dart';

class BlockUserListScreen extends StatelessWidget {
  const BlockUserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BlockUserListController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.blockUserTitle, showBack: true),
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
            child: CustomText(
              title: '${ConstString.currentlyBlocked} (${c.blockedUsers.length})',
              textSize: 13.sp,
              textColor: ConstColor.grey,
              maxLine: 1,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: c.blockedUsers.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (_, i) => _BlockedTile(user: c.blockedUsers[i], controller: c),
            ),
          ),
        ],
      )),
    );
  }
}

class _BlockedTile extends StatelessWidget {
  final BlockedUserModel user;
  final BlockUserListController controller;
  const _BlockedTile({required this.user, required this.controller});

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
                CustomText(title: user.name, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
                SizedBox(height: 2.h),
                CustomText(title: '${ConstString.blockedSince}${user.blockedSince}', textSize: 12.sp, textColor: ConstColor.grey, maxLine: 1),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.onUnblockTap(user),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: ConstColor.primaryColor),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CustomText(
                title: ConstString.unblock,
                textSize: 13.sp,
                fontWeight: FontWeight.w500,
                textColor: ConstColor.primaryColor,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
