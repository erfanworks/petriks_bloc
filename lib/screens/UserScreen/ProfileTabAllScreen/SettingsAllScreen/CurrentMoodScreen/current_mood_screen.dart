import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/current_mood_controller.dart';

class CurrentMoodScreen extends StatelessWidget {
  const CurrentMoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CurrentMoodController>();
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.currentMood, showBack: true),
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
                        color: isSelected
                            ? ConstColor.primaryColor.withAlpha(20)
                            : ConstColor.boxColor,
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
                      child: CustomText(
                        title: item.title,
                        textSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        textColor: ConstColor.black,
                        maxLine: 1,
                      ),
                    ),
                    if (isSelected)
                      Container(
                        width: 26.r,
                        height: 26.r,
                        decoration: const BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14.sp,
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
