import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../AddCardAndBanner/add_screen.dart';
import 'Controller/feed_controller.dart';
import 'Widget/feed_post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    return SingleChildScrollView(
      key: const PageStorageKey('feed_scroll_key'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ConstColor.primaryDeepColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 12.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: InkWell(
              onTap: controller.onCreatePost,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        ClipOval(
                          child: AppImage(
                            path: 'assets/images/onboarding2_img.jpg',
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: ConstColor.boxColor,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: TextField(

                              onTap: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                Get.toNamed(AppRoutes.createPostScreen);},
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: ConstString.whatWouldYouLikeToShare,
                                hintStyle: TextStyle(
                                  color: ConstColor.grey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: TextStyle(
                                color: ConstColor.textColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Divider(
                    height: 1,
                    thickness: 1,
                    color: ConstColor.borderColor.withAlpha(80),
                  ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _ActionChip(
                            icon: Icons.image,
                            iconColor: const Color(0xFF22C55E),
                            label: ConstString.photo,
                            onTap: controller.onPostPhoto,
                          ),
                        ),
                        Expanded(
                          child: _ActionChip(
                            icon: Icons.people,
                            iconColor: const Color(0xFF3B82F6),
                            label: ConstString.tagFriends,
                            onTap: controller.onTagFriends,
                          ),
                        ),
                        Expanded(
                          child: _ActionChip(
                            icon: Icons.emoji_emotions,
                            iconColor: const Color(0xFFFBBF24),
                            label: ConstString.feeling,
                            onTap: controller.onFeeling,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 18.h),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.posts.length + 2,
            itemBuilder: (_, index) {
              if (index == 1) return const SponsoredLocalOfferCard();
              if (index == 3) return const BannerAdCard();

              int postIndex = index;
              if (index > 1) postIndex--;
              if (index > 3) postIndex--;

              if (postIndex >= controller.posts.length) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: FeedPostCard(post: controller.posts[postIndex]),
              );
            },
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

// ---- Action Chip ----
class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16.sp),
          SizedBox(width: 4.w),
          CustomText(
            title: label,
            textColor: ConstColor.textColor,
            textSize: 12.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}