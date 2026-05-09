import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import 'Controller/create_competition_controller.dart';

class SelectActivityScreen extends StatelessWidget {
  const SelectActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(title: ConstString.createCommunity),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 4.h),
            child: CustomText(
              title: ConstString.selectActivity,
              textColor: ConstColor.black,
              textSize: 24.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              title: ConstString.selectActivitySubtitle,
              textColor: ConstColor.grey,
              textSize: 16.sp,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
                childAspectRatio: 1.2,
              ),
              itemCount: c.activities.length,
              itemBuilder: (_, i) {
                return Obx(() {
                  final isSelected = c.selectedActivity.value == i;
                  return GestureDetector(
                    onTap: () => c.selectActivity(i),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: isSelected
                            ? Border.all(color: ConstColor.primaryColor, width: 1.5.w)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ConstColor.primaryColor.withAlpha(20)
                                  : ConstColor.boxColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                c.activities[i].icon,
                                width: 28.w,
                                height: 28.h,
                                colorFilter: ColorFilter.mode(
                                  isSelected ? ConstColor.primaryColor : ConstColor.textColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            title: c.activities[i].name,
                            textColor: isSelected ? ConstColor.primaryColor : ConstColor.black,
                            textSize: 15.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            textAlign: TextAlign.center,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: c.goToMatchDetails,
          height: 48, top: 0, buttonBorderRadius: 30,
          gradient: const[ConstColor.primaryDeepColor,ConstColor.primaryColor],
          child: CustomText(title: ConstString.continueText, textColor: Colors.white, textSize: 15.sp, fontWeight: FontWeight.w600, maxLine: 1),
        ),
      ),
    );
  }
}