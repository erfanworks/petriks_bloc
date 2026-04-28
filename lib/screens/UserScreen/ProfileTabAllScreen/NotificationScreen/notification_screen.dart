import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.notification),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _SectionLabel(title: ConstString.recentActivity),
            SizedBox(height: 10.h),
            _NotificationGroup(items: c.recentActivity),
            SizedBox(height: 20.h),
            _SectionLabel(title: ConstString.yesterday),
            SizedBox(height: 10.h),
            _NotificationGroup(items: c.yesterday),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => CustomText(
    title: title,
    textSize: 16.sp,
    fontWeight: FontWeight.w700,
    textColor: ConstColor.black,
    maxLine: 1,
  );
}

class _NotificationGroup extends StatelessWidget {
  const _NotificationGroup({required this.items});
  final List<NotificationItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, _) => Divider(
          height: 1,
          color: ConstColor.borderColor.withAlpha(120),
          indent: 72.w,
        ),
        itemBuilder: (_, i) => _NotificationTile(item: items[i]),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});
  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          ClipOval(
            child: AppImage(
              path: item.image,
              width: 50.r,
              height: 50.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rich text: name + message + planName + emoji
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Roboto',
                      color: ConstColor.black,
                    ),
                    children: [
                      TextSpan(
                        text: '${item.name} ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '${item.message} '),
                      TextSpan(
                        text: '"${item.planName}" ',
                        style: TextStyle(
                          color: ConstColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: item.planEmoji),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: item.time,
                  textSize: 12.sp,
                  textColor: ConstColor.grey,
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