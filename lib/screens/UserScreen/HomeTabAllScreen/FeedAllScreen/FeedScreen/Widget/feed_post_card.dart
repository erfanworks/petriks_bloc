import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../Controller/feed_controller.dart';

class FeedPostCard extends StatelessWidget {
  final FeedPost post;

  const FeedPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: ConstColor.borderColor,width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
            child: Row(
              children: [
                ClipOval(
                  child: AppImage(
                    path: post.userImage,
                    width: 38.w,
                    height: 38.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: post.userName,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                      ),
                      CustomText(
                        title: post.timeAgo,
                        textColor: ConstColor.black,
                        fontWeight: FontWeight.w500,
                        textSize: 11.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.onMore(post),
                  child: Icon(Icons.more_horiz, color: ConstColor.black, size: 20.sp),
                ),
              ],
            ),
          ),


          if (post.postImage != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: AppImage(
                    path: post.postImage!,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                if (post.locationTag != null)
                  Positioned(
                    bottom: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: ConstColor.primaryColor, size: 13.sp),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: post.locationTag!,
                            textColor: Colors.white,
                            textSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),


          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: CustomText(
              title: post.content,
              textColor: ConstColor.textColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 5,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Obx(() => GestureDetector(
                  onTap: () => controller.onLike(post),
                  child: Row(
                    children: [
                      Icon(
                        controller.isLiked.value
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: controller.isLiked.value
                            ? Colors.red
                            : ConstColor.grey,
                        size: 20.sp,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: controller.isLiked.value
                            ? '${controller.likeCount.value}'
                            : '${post.likes}',
                        textColor: ConstColor.silverGray20,
                        fontWeight: FontWeight.w600,
                        textSize: 12.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                )),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: () => controller.onComment(post),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble_outline_rounded,
                          color: ConstColor.grey, size: 20.sp),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: '${post.comments}',
                        textColor: ConstColor.silverGray20,
                        fontWeight: FontWeight.w600,
                        textSize: 12.sp,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            child: Row(
              children: [
                SizedBox(
                  width: 36.w,
                  height: 18.h,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: ClipOval(
                          child: AppImage(
                            path: 'assets/images/person1_img.jpg',
                            width: 18.w,
                            height: 18.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        child: ClipOval(
                          child: AppImage(
                            path: 'assets/images/onboarding5_img.jpg',
                            width: 18.w,
                            height: 18.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6.w),
                Flexible(
                  child: CustomText(
                    title: post.likedByText,
                    textColor: ConstColor.black,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
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