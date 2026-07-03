import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/weekly_availability_controller.dart';

class WeeklyAvailabilityScreen extends StatelessWidget {
  const WeeklyAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<WeeklyAvailabilityController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.weeklyAvailability,
        showBack: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: c.items.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (_, i) {
          return Obx(() {
            final item = c.items[i];
            final isSelected = c.selectedIndex.value == i;
            return GestureDetector(
              onTap: () => c.select(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: ConstColor.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: isSelected
                        ? ConstColor.primaryColor
                        : ConstColor.borderColor,
                    width: isSelected ? 1.8 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: BoxDecoration(
                        color: item.bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          item.emoji,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: item.title,
                            textSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            textColor: ConstColor.black,
                            maxLine: 1,
                          ),
                          SizedBox(height: 3.h),
                          CustomText(
                            title: item.subtitle,
                            textSize: 12.sp,
                            textColor: ConstColor.grey,
                            maxLine: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          16.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.onSave,
          height: 52,
          top: 0,
          buttonBorderRadius: 30,
          gradient: const [
            ConstColor.primaryDeepColor,
            ConstColor.primaryColor,
          ],
          child: CustomText(
            title: ConstString.save,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: Colors.white,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}
