import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
import 'Controller/edit_group_controller.dart';

class EditGroupScreen extends StatelessWidget {
  const EditGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MyGroupController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: ConstString.editGroup, showBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cover Photo ──
            Obx(() => Stack(
              children: [
                AppImage(
                  filePath: c.coverImagePath.value.isNotEmpty ? c.coverImagePath.value : null,
                  path: c.coverImagePath.value.isEmpty ? 'assets/images/fotball_img.jpg' : null,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 12.h, left: 0, right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => MediaPickerBottomSheet.show(
                        onGallery: c.pickFromGallery,
                        onCamera: c.pickFromCamera,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(140),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 16.sp),
                            SizedBox(width: 6.w),
                            CustomText(title: ConstString.changeCover, textSize: 13.sp, fontWeight: FontWeight.w500, textColor: Colors.white, maxLine: 1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),

            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Group Name ──
                  _Label(ConstString.groupName),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 18.sp, color: ConstColor.primaryColor),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: TextField(
                            controller: c.nameController,
                            style: TextStyle(fontSize: 15.sp, color: ConstColor.black),
                            decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── Short Description ──
                  _Label(ConstString.shortDescription),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: ConstColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: TextField(
                      controller: c.descController,
                      maxLines: 4,
                      style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
                      decoration: InputDecoration(
                        border: InputBorder.none, isDense: true,
                        hintText: ConstString.shortDescHint,
                        hintStyle: TextStyle(color: ConstColor.grey, fontSize: 14.sp),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Group Limit ──
                  CustomText(title: ConstString.groupLimit, textSize: 16.sp, fontWeight: FontWeight.w700, textColor: ConstColor.black, maxLine: 1),
                  SizedBox(height: 12.h),
                  Obx(() => Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: ConstColor.boxColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: c.groupLimits.asMap().entries.map((e) {
                        final isSelected = c.selectedLimitIndex.value == e.key;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => c.selectLimit(e.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: isSelected ? ConstColor.primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(26.r),
                              ),
                              child: Center(
                                child: CustomText(
                                  title: e.value,
                                  textSize: 14.sp,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  textColor: isSelected ? Colors.white : ConstColor.textColor,
                                  maxLine: 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h + MediaQuery.of(context).padding.bottom),
        child: CustomElevatedButton(
          onPressed: c.onSave,
          height: 52, top: 0, buttonBorderRadius: 30,
          gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          child: CustomText(title: ConstString.saveChanges, textSize: 16.sp, fontWeight: FontWeight.w600, textColor: Colors.white, maxLine: 1),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => CustomText(
    title: text, textSize: 13.sp, fontWeight: FontWeight.w500,
    textColor: ConstColor.grey, maxLine: 1,
  );
}