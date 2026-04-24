import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Controller/one_to_one_meetup_controller.dart';
import 'Widget/one_to_one_meetup_card.dart';

class OneToOneMeetupScreen extends StatelessWidget {
  const OneToOneMeetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OneToOneMeetupController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.meetups.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (_, index) => OneToOneMeetupCard(
              item: controller.meetups[index],
            ),
          ),
        ],
      ),
    );
  }
}

