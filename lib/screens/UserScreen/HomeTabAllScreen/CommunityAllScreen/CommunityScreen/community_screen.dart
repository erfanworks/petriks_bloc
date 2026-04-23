import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/community_controller.dart';
import 'Widget/community_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(
                  controller.communityTabs.length,
                      (i) {
                    final isSelected = controller.selectedCommunityTab.value == i;
                    return GestureDetector(
                      onTap: () => controller.selectedCommunityTab.value = i,
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.only(bottom: 2.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? ConstColor.primaryColor : Colors.transparent,
                              width: 2.h,
                            ),
                          ),
                        ),
                        child: CustomText(
                          title: controller.communityTabs[i],
                          textColor: isSelected ? ConstColor.primaryColor : ConstColor.grey,
                          textSize: 14.sp,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          maxLine: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // ---- Community Cards ----
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.communities.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (_, index) => CommunityCard(
              item: controller.communities[index],
              onTap: () => controller.onViewCommunity(controller.communities[index]),
            ),
          ),

          SizedBox(height: 24.h),

          // ---- App News ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.appNews,
              textColor: ConstColor.black,
              textSize: 22.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
          ),

          SizedBox(height: 12.h),

          ...controller.appNews.map((news) => _AppNewsItem(item: news)),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}



// ---- App News Item ----
class _AppNewsItem extends StatelessWidget {
  final AppNewsItem item;

  const _AppNewsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xFFEDE9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(item.emoji, style: TextStyle(fontSize: 18.sp)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: item.title,
                  textColor: ConstColor.black,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  title: item.description,
                  textColor: ConstColor.grey,
                  textSize: 14.sp,
                  maxLine: 3,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: item.timeAgo,
                  textColor: ConstColor.primaryDeepColor,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}