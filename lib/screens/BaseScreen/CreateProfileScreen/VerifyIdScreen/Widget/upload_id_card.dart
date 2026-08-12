import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../Controller/verify_id_controller.dart';

class UploadIdCard extends StatelessWidget {
  const UploadIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<VerifyIdController>();

    return Obx(() {
      final hasImage = c.hasIdImage;

      return GestureDetector(
        onTap: hasImage ? null : c.onIdUploadTap,
        child: _InfoCard(
          child: hasImage
              ? _ImagePreview(c: c)
              : _EmptyUpload(),
        ),
      );
    });
  }
}

// ─── Empty Upload State (original design unchanged) ───────────────────────────
class _EmptyUpload extends StatelessWidget {
  const _EmptyUpload();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.r,
          height: 48.r,
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/gellary_icon.svg',
              width: 22.r,
              height: 22.r,
              colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.uploadIdFor,
              textSize: 16.sp,
              fontWeight: FontWeight.w700,
              textColor: const Color(0xFF1A1A2E),
              maxLine: 1,
            ),
            SizedBox(height: 2.h),
            CustomText(
              title: 'PDF, PNG, Zip',
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              textColor: ConstColor.grey,
              maxLine: 1,
            ),
          ],
        ),
      ],
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final VerifyIdController c;
  const _ImagePreview({required this.c});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            c.selectedIdImage.value!,
            width: double.infinity,
            height: 180.h,
            fit: BoxFit.contain,
          ),
        ),

        Positioned(
          top: 8.h,
          right: 8.w,
          child: GestureDetector(
            onTap: c.onIdUploadTap,
            child: Container(
              width: 32.r,
              height: 32.r,
              decoration: BoxDecoration(
                color: ConstColor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 6),
                ],
              ),
              child: Center(
                child: Icon(Icons.edit_rounded, size: 16.sp, color: ConstColor.primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }
}
