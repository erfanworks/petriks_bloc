import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Widget/text/custom_text.dart';
import '../../constant/const_color.dart';
import '../../constant/const_string.dart';
import '../AppImage/app_image.dart';
import '../CustomElevatedButton/custom_elevated_button.dart';
import '../CustomTextFormField/custom_text_form_field.dart';

void showAddCustomLocationSheet({
  required RxString imagePath,
  required Function(String path) onPickImage,
  required TextEditingController nameController,
  required TextEditingController addressController,
  required TextEditingController subtitleController,
  required bool Function() canAdd,
  required VoidCallback onAdd,
  required RxInt formTick,
  String? title,
  String? buttonTitle,
}) {
  Get.bottomSheet(
    AddCustomLocationSheet(
      imagePath: imagePath,
      onPickImage: onPickImage,
      nameController: nameController,
      addressController: addressController,
      subtitleController: subtitleController,
      canAdd: canAdd,
      onAdd: onAdd,
      formTick: formTick,
      title: title,
      buttonTitle: buttonTitle,
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class AddCustomLocationSheet extends StatelessWidget {
  final RxString imagePath;
  final Function(String path) onPickImage;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController subtitleController;
  final bool Function() canAdd;
  final VoidCallback onAdd;
  final RxInt formTick;
  final String? title;
  final String? buttonTitle;

  const AddCustomLocationSheet({
    super.key,
    required this.imagePath,
    required this.onPickImage,
    required this.nameController,
    required this.addressController,
    required this.subtitleController,
    required this.canAdd,
    required this.onAdd,
    required this.formTick,
    this.title,
    this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          24.h + MediaQuery.of(context).padding.bottom,
        ),
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
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ConstColor.borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              CustomText(
                title: title ?? ConstString.addCustomLocation,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: ConstColor.black,
                maxLine: 1,
              ),
              SizedBox(height: 16.h),

              // ── Image picker ──
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    final picked = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) onPickImage(picked.path);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: ConstColor.boxColor,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: ConstColor.borderColor),
                    ),
                    child: imagePath.value.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                color: ConstColor.primaryColor,
                                size: 26.sp,
                              ),
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
                              filePath: imagePath.value,
                              width: double.infinity,
                              height: 140.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeName,
                textController: nameController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeAddress,
                textController: addressController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 12.h),

              CustomTextFormField(
                backgroundColor: ConstColor.boxColor,
                fromTitle: ConstString.placeSubtitleOptional,
                textController: subtitleController,
                hintText: const SizedBox.shrink(),
              ),
              SizedBox(height: 20.h),

              Obx(() {
                formTick.value;
                imagePath.value; // reactive trigger
                return CustomElevatedButton(
                  onPressed: canAdd()
                      ? () {
                          onAdd();
                          Get.back();
                        }
                      : null,
                  height: 50,
                  top: 0,
                  buttonBorderRadius: 30,
                  gradient: const [
                    ConstColor.primaryDeepColor,
                    ConstColor.primaryColor,
                  ],
                  child: CustomText(
                    title: buttonTitle ?? ConstString.addLocation,
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
      ),
    );
  }
}
