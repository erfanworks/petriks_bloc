import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyCommunityDetailScreen/Controller/my_community_detail_controller.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

class MyGroupDetailScreen extends StatelessWidget {
  const MyGroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyCommunityDetailController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.groupDetails,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Stack(
              children: [
                AppImage(
                  path: 'assets/images/football_play.jpg',
                  width: double.infinity,
                  height: 220.h,
                  fit: BoxFit.cover,
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withAlpha(70),
                          Colors.transparent,
                          Colors.black.withAlpha(180),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: _TagBadge(label: 'FITNESS'),
                ),

                // ─── Text & Details ───
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: 'Morning Runners',
                        textColor: Colors.white,
                        textSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people_outline,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: '1,248 members',
                            textColor: Colors.white,
                            textSize: 16.sp,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // ---- About ----
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.about,
                    textColor: ConstColor.black,
                    textSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    title:
                    'We are a collective of high- performance movers who treat the concrete as our playground. Pushing urban endurance limits through collaborative training, competitive heat, and shared grit.',
                    textColor: ConstColor.grey,
                    textSize: 15.sp,
                    maxLine: 6,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // ---- Group Progress Stats ----
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.groupProgress,
                    textColor: ConstColor.black,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      _StatBox(
                        icon: Icons.flag_outlined,
                        iconColor: ConstColor.primaryColor,
                        value: '6',
                        label: 'Matches',
                      ),
                      SizedBox(width: 16.w),
                      _StatBox(
                        icon: Icons.emoji_events_outlined,
                        iconColor: const Color(0xFFFF9800),
                        value: '4',
                        label: 'Wins',
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      _StatBox(
                        icon: Icons.bar_chart_rounded,
                        iconColor: ConstColor.primaryColor,
                        value: '#2',
                        label: 'GLOBAL RANK',
                      ),
                      SizedBox(width: 16.w),
                      _StatBox(
                        icon: Icons.calendar_today_outlined,
                        iconColor: ConstColor.primaryColor,
                        value: 'Sunday',
                        label: 'Next Match',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Competitions ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.competitions,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 10.h),
            ...c.competitions.map((comp) => _CompetitionListItem(item: comp)),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
        child: CustomElevatedButton(
          onPressed: (){Get.toNamed(AppRoutes.inviteFriendsListScreen);},
          height: 50,
          top: 0,
          buttonBorderRadius: 30,
          gradient: [ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.inviteFriends,
            textColor: Colors.white,
            textSize: 16.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}
class _TagBadge extends StatelessWidget {
  final String label;

  const _TagBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ConstColor.white.withAlpha(180),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        title: label,
        textColor: ConstColor.primaryColor,
        textSize: 12.sp,
        fontWeight: FontWeight.w700,
        maxLine: 1,
      ),
    );
  }
}
class _CompetitionListItem extends StatelessWidget {
  final CompetitionItem item;

  const _CompetitionListItem({required this.item});

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
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(item.emoji, style: TextStyle(fontSize: 20.sp)),
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
                Row(
                  children: [
                    Container(
                      width: 7.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isUpcoming
                            ? ConstColor.primaryColor
                            : Colors.red,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    CustomText(
                      title: item.status,
                      textColor: ConstColor.grey,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: ConstColor.grey,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
class _StatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: value,
                textColor: ConstColor.black,
                textSize: 18.sp,
                fontWeight: FontWeight.w800,
                maxLine: 1,
              ),
              CustomText(
                title: label,
                textColor: ConstColor.grey,
                fontWeight: FontWeight.w500,
                textSize: 10.sp,
                maxLine: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}