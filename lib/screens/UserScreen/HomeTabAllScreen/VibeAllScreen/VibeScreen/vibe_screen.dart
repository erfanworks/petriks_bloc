import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../AddCardAndBanner/add_screen.dart';
import '../OneToOneMeetupScreen/one_to_one_meetup_screen.dart';
import 'Controller/vibe_controller.dart';
import 'Widget/viibe_event_card.dart';

class VibeScreen extends StatelessWidget {
  const VibeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VibeController>();

    return SingleChildScrollView(
      key: const PageStorageKey('vibe_scroll_key'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 20.h),
          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(
                  controller.vibeTabs.length,
                      (i) {
                    final isSelected = controller.selectedVibeTab.value == i;
                    return GestureDetector(
                      onTap: () => controller.selectedVibeTab.value = i,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected
                                  ? ConstColor.primaryColor
                                  : ConstColor.borderColor,
                              width: isSelected ? 2.5.h : 1.5.h,
                            ),
                          ),
                        ),
                        child: CustomText(
                          title: controller.vibeTabs[i],
                          textColor: isSelected
                              ? ConstColor.primaryColor
                              : ConstColor.grey,
                          textSize: 14.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          maxLine: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.howAreYouFeeling,
              textColor: ConstColor.black,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),

          SizedBox(height: 10.h),

          Obx(
                () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(
                  controller.feelingFilters.length,
                      (i) {
                    final isSelected = controller.selectedFeeling.value == i;
                    return GestureDetector(
                      onTap: () => controller.selectedFeeling.value = i,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 7.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ConstColor.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CustomText(
                          title: controller.feelingFilters[i],
                          textColor:
                          isSelected ? Colors.white : ConstColor.textColor,
                          textSize: 14.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          maxLine: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SizedBox(height: 18.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.whoToMeet,
              textColor: ConstColor.grey,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),

          SizedBox(height: 8.h),

          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: ConstColor.borderColor.withAlpha(120),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: List.generate(
                    controller.meetFilters.length,
                        (i) {
                      final isSelected = controller.selectedMeet.value == i;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedMeet.value = i,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(24.r),

                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: Colors.black.withAlpha(15),
                                  blurRadius: 8.r,
                                  offset: Offset(0, 2.h),
                                )
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: CustomText(
                                title: controller.meetFilters[i],
                                textColor: isSelected
                                    ? ConstColor.primaryColor
                                    : ConstColor.textColor,
                                textSize: 13.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                maxLine: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Obx(() => IndexedStack(
            index: controller.selectedVibeTab.value,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.events.length + 2,
                itemBuilder: (_, index) {
                  if (index == 1) return const PartnerLocalOfferCard();
                  if (index == 3) return const BannerAdCard();

                  int eventIndex = index;
                  if (index > 1) eventIndex--;
                  if (index > 3) eventIndex--;

                  if (eventIndex >= controller.events.length) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: VibeEventCard(item: controller.events[eventIndex]),
                  );
                },
              ),

              const OneToOneMeetupScreen(),
            ],
          )),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}