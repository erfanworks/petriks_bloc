import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

void showFilterSheet() {
  Get.bottomSheet(
    const _FilterSheet(),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    isScrollControlled: true,
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  String? selectedCity;
  double radius = 40;
  bool isDropdownOpen = false;

  final List<String> cities = [
    'London',
    'Birmingham',
    'Manchester',
    'Glasgow',
    'Leeds',
    'Liverpool',
  ];

  final List<String> feelingFilters = ['Quiet', 'Easy Going', 'Social', 'Lively'];
  int selectedFeeling = 1;

  final List<String> meetFilters = ['Everyone', 'Women', 'Men'];
  int selectedMeet = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: ConstString.filter,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              GestureDetector(
                onTap: Get.back,
                child: Icon(Icons.close, size: 22.sp, color: ConstColor.black),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          CustomText(
            title: ConstString.city,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.black,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () => setState(() => isDropdownOpen = !isDropdownOpen),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: ConstColor.boxColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      title: selectedCity ?? ConstString.selectCity,
                      textSize: 15.sp,
                      textColor: selectedCity != null ? ConstColor.black : ConstColor.grey,
                      maxLine: 1,
                    ),
                  ),
                  Icon(
                    isDropdownOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20.sp,
                    color: ConstColor.grey,
                  ),
                ],
              ),
            ),
          ),

          if (isDropdownOpen)
            Container(
              margin: EdgeInsets.only(top: 4.h),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ConstColor.borderColor),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8),
                ],
              ),
              child: Column(
                children: cities
                    .map(
                      (city) => GestureDetector(
                    onTap: () => setState(() {
                      selectedCity = city;
                      isDropdownOpen = false;
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              title: city,
                              textSize: 14.sp,
                              textColor: ConstColor.black,
                              maxLine: 1,
                            ),
                          ),
                          if (selectedCity == city)
                            Icon(Icons.check, size: 16.sp, color: ConstColor.primaryColor),
                        ],
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),

          SizedBox(height: 20.h),

          // CustomText(
          //   title: "How are you feeling?",
          //   textColor: ConstColor.black,
          //   textSize: 14.sp,
          //   fontWeight: FontWeight.w600,
          //   maxLine: 1,
          // ),
          // SizedBox(height: 10.h),
          //
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: List.generate(
          //       feelingFilters.length,
          //           (i) {
          //         final isSelected = selectedFeeling == i;
          //         return GestureDetector(
          //           onTap: () => setState(() => selectedFeeling = i),
          //           child: AnimatedContainer(
          //             duration: const Duration(milliseconds: 200),
          //             margin: EdgeInsets.only(right: 8.w),
          //             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          //             decoration: BoxDecoration(
          //               color: isSelected ? ConstColor.primaryColor : Colors.white,
          //               borderRadius: BorderRadius.circular(20.r),
          //             ),
          //             child: CustomText(
          //               title: feelingFilters[i],
          //               textColor: isSelected ? Colors.white : ConstColor.textColor,
          //               textSize: 14.sp,
          //               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          //               maxLine: 1,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          //
          // SizedBox(height: 20.h),
          //
          // CustomText(
          //   title: "Who would you like to meet?",
          //   textColor: ConstColor.black,
          //   textSize: 14.sp,
          //   fontWeight: FontWeight.w600,
          //   maxLine: 1,
          // ),
          // SizedBox(height: 10.h),
          //
          // Container(
          //   decoration: BoxDecoration(
          //     color: ConstColor.borderColor.withAlpha(50),
          //     borderRadius: BorderRadius.circular(30.r),
          //   ),
          //   padding: EdgeInsets.all(4.w),
          //   child: Row(
          //     children: List.generate(
          //       meetFilters.length,
          //           (i) {
          //         final isSelected = selectedMeet == i;
          //         return Expanded(
          //           child: GestureDetector(
          //             onTap: () => setState(() => selectedMeet = i),
          //             child: AnimatedContainer(
          //               duration: const Duration(milliseconds: 200),
          //               padding: EdgeInsets.symmetric(vertical: 10.h),
          //               decoration: BoxDecoration(
          //                 color: isSelected ? Colors.white : Colors.transparent,
          //                 borderRadius: BorderRadius.circular(24.r),
          //                 boxShadow: isSelected
          //                     ? [
          //                   BoxShadow(
          //                     color: Colors.black.withAlpha(15),
          //                     blurRadius: 8.r,
          //                     offset: Offset(0, 2.h),
          //                   )
          //                 ]
          //                     : [],
          //               ),
          //               child: Center(
          //                 child: CustomText(
          //                   title: meetFilters[i],
          //                   textColor: isSelected ? ConstColor.primaryColor : ConstColor.textColor,
          //                   textSize: 13.sp,
          //                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          //                   maxLine: 1,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          //
          // SizedBox(height: 20.h),

          CustomText(
            title: ConstString.radius,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.black,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ConstColor.primaryColor,
              inactiveTrackColor: ConstColor.borderColor,
              thumbColor: ConstColor.primaryColor,
              overlayColor: ConstColor.primaryColor.withAlpha(30),
              trackHeight: 4.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 11.r),
            ),
            child: Slider(
              value: radius,
              min: 1,
              max: 100,
              onChanged: (val) => setState(() => radius = val),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: '${radius.toInt()}km',
                  textSize: 13.sp,
                  textColor: ConstColor.grey,
                  maxLine: 1,
                ),
                CustomText(
                  title: ConstString.radius100km,
                  textSize: 13.sp,
                  textColor: ConstColor.grey,
                  maxLine: 1,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Align(
            alignment: Alignment.centerRight,
            child: CustomElevatedButton(
              onPressed: () {
                // TODO
                Get.back();
              },
              gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
              height: 44,
              width: 110,
              top: 0,
              buttonBorderRadius: 30,
              child: CustomText(
                title: ConstString.apply,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.white,
                maxLine: 1,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}