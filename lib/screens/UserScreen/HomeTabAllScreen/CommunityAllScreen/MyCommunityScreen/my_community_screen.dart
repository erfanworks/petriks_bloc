import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import 'Controller/my_community_controller.dart';
import 'Widget/my_community_card.dart';

class MyCommunityScreen extends StatelessWidget {
  const MyCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyCommunityController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          _InviteFriendsButton(),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.myCommunities.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (_, index) => MyCommunityCard(
              item: controller.myCommunities[index],
              onTap: () {
                Get.toNamed(AppRoutes.myCommunityDetailScreen);
              },
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}




class _InviteFriendsButton extends StatelessWidget {

  const _InviteFriendsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: (){
          Get.toNamed(AppRoutes.createCommunityScreen);
        },
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
                  Icons.group,
                  color: ConstColor.primaryColor,
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  title: ConstString.createCommunity,
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