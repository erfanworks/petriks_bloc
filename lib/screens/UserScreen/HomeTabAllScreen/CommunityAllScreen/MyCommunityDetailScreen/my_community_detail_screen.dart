import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../ViewCompetitionScreen/Controller/view_competition_controller.dart';
import 'Controller/my_community_detail_controller.dart';
import 'Widget/my_group_card.dart';

class MyCommunityDetailScreen extends StatelessWidget {
  const MyCommunityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyCommunityDetailController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(
        title: ConstString.communityDetails,
        actions: [
          controller.isOwner.value
              ? PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert, color: ConstColor.black),
                  offset: const Offset(-10, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 1) {
                      controller.onEditCommunity();
                    } else if (value == 2) {
                      controller.onDeleteCommunity();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: CustomText(
                        title: 'Edit Community',
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: CustomText(
                        title: 'Delete community',
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(title: "Active Group", count: "05"),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: _StatCard(title: "Live Competitions", count: "04"),
                  ),
                ],
              ),
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
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    title:
                        'We are a collective of high- performance movers who treat the concrete as our playground. Pushing urban endurance limits through collaborative training, competitive heat, and shared grit.',
                    textColor: ConstColor.textColor,
                    textSize: 16.sp,
                    maxLine: 6,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // ---- Groups ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: "Active Groups",
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: controller.isOwner.value
                  ? controller.groups.length
                  : 1,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, i) {
                final GroupItem currentItem = controller.groups[i];
                return MyGroupCard(
                  item: currentItem,
                  onTap: () => controller.onViewGroup(currentItem),
                );
              },
            ),

            SizedBox(height: 20.h),

            // ---- Group Progress ----
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.groupProgress,
                textColor: ConstColor.black,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
            SizedBox(height: 10.h),
            _ProgressTable(teams: controller.progressTeams),
            SizedBox(height: 10.h),
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
            Obx(
              () => Column(
                children: controller.competitions
                    .map(
                      (comp) => _CompetitionListItem(
                        item: comp,
                        isOwner: controller.isOwner.value,
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.isOwner.value
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  0,
                  16.w,
                  4.h + MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  // ─── ERROR FIXED: This prevents the Column from taking the full screen height ───
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomElevatedButton(
                      onPressed: controller.toCreateGroup,
                      height: 48,
                      top: 0,
                      buttonBorderRadius: 30,
                      gradient: [
                        ConstColor.primaryDeepColor,
                        ConstColor.primaryColor,
                      ],
                      child: CustomText(
                        title: ConstString.createGroup,
                        textColor: Colors.white,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomElevatedButton(
                      onPressed: controller.toCreateCompetition,
                      height: 48,
                      elevation: 0,
                      isOutLined: true,
                      outLineColour: ConstColor.primaryColor,
                      top: 0,
                      buttonBorderRadius: 30,
                      child: CustomText(
                        title: ConstString.createCompetition,
                        textColor: ConstColor.primaryColor,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;

  const _StatCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title,
            textColor: ConstColor.silverGray20,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: count,
            textColor: ConstColor.black,
            textSize: 30.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
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

class _ProgressTable extends StatelessWidget {
  final List<ProgressTeam> teams;

  const _ProgressTable({required this.teams});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                SizedBox(width: 24.w),
                CustomText(
                  title: 'POS',
                  textColor: ConstColor.grey,
                  textSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    title: 'GROUP',
                    textColor: ConstColor.grey,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
                ...['M', 'W', 'D', 'L'].map(
                  (h) => SizedBox(
                    width: 28.w,
                    child: CustomText(
                      title: h,
                      textColor: ConstColor.grey,
                      textSize: 10.sp,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...teams.map((t) => _ProgressRow(team: t)),
          // Legend
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                _LegendDot(color: ConstColor.primaryColor, label: 'MATCH'),
                SizedBox(width: 12.w),
                _LegendDot(color: const Color(0xFF4CAF50), label: 'WIN'),
                SizedBox(width: 12.w),
                _LegendDot(color: const Color(0xFFFF9800), label: 'DRAW'),
                SizedBox(width: 12.w),
                _LegendDot(color: Colors.red, label: 'LOSS'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final ProgressTeam team;

  const _ProgressRow({required this.team});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          CustomText(
            title: team.position,
            textColor: ConstColor.primaryDeepColor,
            textSize: 18.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(width: 8.w),
          Text(team.emoji, style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 6.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: team.name,
                  textColor: ConstColor.black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                CustomText(
                  title: team.city,
                  textColor: ConstColor.grey,
                  textSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          ...[team.matches, team.wins, team.draws, team.losses].map(
            (v) => SizedBox(
              width: 28.w,
              child: CustomText(
                title: '$v',
                textColor: ConstColor.black,
                textSize: 12.sp,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 4.w),
        CustomText(
          title: label,
          textColor: ConstColor.grey,
          textSize: 10.sp,
          fontWeight: FontWeight.w700,
          maxLine: 1,
        ),
      ],
    );
  }
}

class _CompetitionListItem extends StatelessWidget {
  final CompetitionItem item;
  final bool isOwner;

  const _CompetitionListItem({required this.item, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: InkWell(
        onTap: () {
          Get.find<ViewCompetitionController>().setOwner(isOwner);
          Get.toNamed(AppRoutes.viewCompetitionScreen);
        },
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
      ),
    );
  }
}
