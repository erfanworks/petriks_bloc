import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/AppImage/app_image.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../Controller/create_competition_controller.dart';

void showAddCustomMatchLocationSheet() {
  Get.bottomSheet(
    const _AddCustomMatchLocationSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class _AddCustomMatchLocationSheet extends StatelessWidget {
  const _AddCustomMatchLocationSheet();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CreateCompetitionController>();

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h + MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w, height: 4.h,
                  decoration: BoxDecoration(
                    color: ConstColor.borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              CustomText(
                title: ConstString.addCustomLocation,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              SizedBox(height: 16.h),

              Obx(() => GestureDetector(
                onTap: () async {
                  final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (picked != null) c.pickCustomMatchLocationImage(picked.path);
                },
                child: Container(
                  width: double.infinity,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: ConstColor.boxColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: ConstColor.borderColor),
                  ),
                  child: c.customMatchLocationImagePath.value.isEmpty
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined, color: ConstColor.primaryColor, size: 26.sp),
                      SizedBox(height: 6.h),
                      CustomText(
                        title: ConstString.uploadPlaceImage,
                        textSize: 13.sp,
                        textColor: ConstColor.grey,
                        maxLine: 1,
                      ),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(14.r),
                    child: AppImage(
                      filePath: c.customMatchLocationImagePath.value,
                      width: double.infinity,
                      height: 140.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
              SizedBox(height: 14.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeName,
                textController: c.customMatchLocationNameController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeAddress,
                textController: c.customMatchLocationAddressController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeSubtitleOptional,
                textController: c.customMatchLocationSubtitleController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 20.h),

              Obx(() {
                c.customMatchLocationFormTick.value;
                c.customMatchLocationImagePath.value;
                return CustomElevatedButton(
                  onPressed: c.canAddCustomMatchLocation
                      ? () {
                    c.addCustomMatchLocation();
                    Get.back();
                  }
                      : null,
                  height: 50,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: const [ConstColor.primaryDeepColor, ConstColor.primaryColor],
                  child: CustomText(
                    title: ConstString.addLocation,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.white,
                    maxLine: 1,
                  ),
                );
              }),
            ],
          ),
        ),
      );
  }
}