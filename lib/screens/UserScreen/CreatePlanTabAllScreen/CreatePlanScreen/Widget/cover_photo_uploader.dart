import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petriks_flutter_app/Widget/CoverRatioHint/cover_ratio_hint.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';

class CoverPhotoUploader extends StatelessWidget {
  final RxString coverPhotoPath;
  final String ratio;
  final String size;

  const CoverPhotoUploader({
    super.key,
    required this.coverPhotoPath,
    this.ratio = '5:2',
    this.size = '1200 × 480 px',
  });

  void _pickImage() {
    final picker = ImagePicker();

    MediaPickerBottomSheet.show(
      onCamera: () async {
        final photo = await picker.pickImage(source: ImageSource.camera);
        if (photo != null) coverPhotoPath.value = photo.path;
      },
      onGallery: () async {
        final photo = await picker.pickImage(source: ImageSource.gallery);
        if (photo != null) coverPhotoPath.value = photo.path;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final hasImage = coverPhotoPath.value.isNotEmpty;

          return GestureDetector(
            onTap: hasImage ? null : _pickImage,
            child: Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: ConstColor.borderColor),
              ),
              child: hasImage
                  ? _ImagePreview(
                      path: coverPhotoPath.value,
                      onEdit: _pickImage,
                    )
                  : _EmptyUpload(),
            ),
          );
        }),
        CoverRatioHint(ratio: ratio, size: size),
      ],
    );
  }
}

class _EmptyUpload extends StatelessWidget {
  const _EmptyUpload();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt_outlined,
          size: 28.r,
          color: ConstColor.iconColor,
        ),
        SizedBox(height: 8.h),
        CustomText(
          title: 'Upload cover photo',
          textColor: ConstColor.iconColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String path;
  final VoidCallback onEdit;

  const _ImagePreview({required this.path, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Image.file(
            File(path),
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(140),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/edit_icon.svg',
                  width: 15.w,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
