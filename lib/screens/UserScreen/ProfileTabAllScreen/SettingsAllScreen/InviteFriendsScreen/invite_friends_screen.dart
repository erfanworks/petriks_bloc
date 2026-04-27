import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../ProfileScreen/Controller/profile_controller.dart';

class InviteFriendsListScreen extends StatelessWidget {
  const InviteFriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.inviteFriends, showBack: true),
      body: Obx(() => ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: c.friends.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (_, i) => _FriendTile(friend: c.friends[i], onInvite: () => c.onInviteFriend(i)),
      )),
    );
  }
}

class _FriendTile extends StatelessWidget {
  final InviteFriendModel friend;
  final VoidCallback onInvite;
  const _FriendTile({required this.friend, required this.onInvite});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(color: ConstColor.white, borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: AppImage(path: friend.image, width: 46.w, height: 46.h, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: friend.name,     textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
                SizedBox(height: 2.h),
                CustomText(title: friend.username, textSize: 12.sp, textColor: ConstColor.grey,  maxLine: 1),
              ],
            ),
          ),
          Obx(() => CustomElevatedButton(
            onPressed: onInvite,
            height: 36,
            width: 80,
            top: 0,
            buttonBorderRadius: 20,
            color: friend.isInvited.value ? ConstColor.boxColor : ConstColor.primaryColor,
            child: CustomText(
              title: ConstString.invite,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              textColor: friend.isInvited.value ? ConstColor.grey : ConstColor.white,
              maxLine: 1,
            ),
          )),
        ],
      ),
    );
  }
}
