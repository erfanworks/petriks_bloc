import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../widget/FullScreenImageViewer/full_screen_image_viewer.dart';
import '../FeedScreen/Controller/feed_controller.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FeedController>();
    return Scaffold(
      backgroundColor: ConstColor.white,
      appBar: GlobalAppBar(title: ConstString.createPost, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _UserInfoRow(),
                  _TagChipsRow(c: c),
                  _PostInputArea(c: c),
                  // Picked image preview
                  Obx(
                    () => c.pickedImagePath.value.isEmpty
                        ? const SizedBox.shrink()
                        : _PickedImagePreview(c: c),
                  ),
                  SizedBox(height: 20.h,)
                ],
              ),
            ),
          ),
          _BottomActions(c: c),
        ],
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  const _UserInfoRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: AppImage(
              path: 'assets/images/onboarding2_img.jpg',
              width: 44.w,
              height: 44.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: 'Alex Rivera',
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.black,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
              SizedBox(height: 2.h),
              const _PublicBadge(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PublicBadge extends StatelessWidget {
  const _PublicBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.public, size: 13.sp, color: ConstColor.textColor),
          SizedBox(width: 4.w),
          CustomText(
            title: ConstString.publicLabel,
            textSize: 12.sp,
            textColor: ConstColor.textColor,
            maxLine: 1,
          ),
          SizedBox(width: 2.w),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 14.sp,
            color: ConstColor.grey,
          ),
        ],
      ),
    );
  }
}

// ─── Tag Chips Row ────────────────────────────────────────────────────────────
class _TagChipsRow extends StatelessWidget {
  final FeedController c;

  const _TagChipsRow({required this.c});

  @override
  Widget build(BuildContext context) {
    final chips = [
      _ChipData(
        icon: 'assets/icons/music_icon.svg',
        label: ConstString.music,
        onTap: () {},
      ),
      _ChipData(
        icon: 'assets/icons/person_icon.svg',
        label: ConstString.people,
        onTap: c.onTagFriends,
      ),
      _ChipData(
        icon: 'assets/icons/location_icon.svg',
        label: ConstString.location,
        onTap: () {},
      ),
      _ChipData(
        icon: 'assets/icons/chill_icon.svg',
        label: ConstString.feeling,
        onTap: c.onFeeling,
      ),
    ];
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: chips.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, i) => _TagChip(data: chips[i]),
      ),
    );
  }
}

class _ChipData {
  final String icon, label;
  final VoidCallback onTap;

  const _ChipData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _TagChip extends StatelessWidget {
  final _ChipData data;

  const _TagChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: ConstColor.white,
          border: Border.all(color: ConstColor.borderColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              data.icon,
              width: 14.w,
              height: 14.h,
              colorFilter: ColorFilter.mode(
                ConstColor.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 6.w),
            CustomText(
              title: data.label,
              textSize: 12.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _PostInputArea extends StatelessWidget {
  final FeedController c;

  const _PostInputArea({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: TextField(
        autofocus: false,
        onChanged: (val) => c.postController.value = val,
        maxLines: null,
        minLines: 8,
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          fontSize: 15.sp,
          color: ConstColor.black,
          fontFamily: 'Roboto',
        ),
        decoration: InputDecoration(
          hintText: ConstString.whatsOnYourMind,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: ConstColor.grey,
            fontFamily: 'Roboto',
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        cursorColor: ConstColor.primaryColor,
      ),
    );
  }
}

class _PickedImagePreview extends StatelessWidget {
  final FeedController c;

  const _PickedImagePreview({required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => openFullScreenImage(c.pickedImagePath.value, isFile: true),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppImage(
                filePath: c.pickedImagePath.value,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () => c.pickedImagePath.value = '',
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(140),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: ConstColor.white, size: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final FeedController c;

  const _BottomActions({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        0,
        16.w,
        5.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: ConstColor.white,
        border: Border(top: BorderSide(color: ConstColor.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: _MediaButton(
                  icon: 'assets/icons/camera_icon.svg',
                  label: ConstString.camera,
                  onTap: c.onPostPhoto,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _MediaButton(
                  icon: 'assets/icons/gellary_icon.svg',
                  label: ConstString.gallery,
                  onTap: c.onPickFromGallery,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() {
            final hasText  = c.postController.value.trim().isNotEmpty;
            final hasImage = c.pickedImagePath.value.isNotEmpty;
            final canPost  = hasText || hasImage;

            return CustomElevatedButton(
              onPressed: c.isPostLoading.value ? null : c.onSubmitPost,
              height: 48,
              gradient: canPost
                  ? [ConstColor.primaryDeepColor, ConstColor.primaryColor]
                  : [ConstColor.primaryColor.withAlpha(100), ConstColor.primaryColor.withAlpha(100)],
              top: 0,
              buttonBorderRadius: 30,
              child: c.isPostLoading.value
                  ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(color: ConstColor.white, strokeWidth: 2),
              )
                  : CustomText(
                title: ConstString.post,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                textColor: ConstColor.white,
                maxLine: 1,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MediaButton extends StatelessWidget {
  final String icon, label;
  final VoidCallback onTap;

  const _MediaButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: ConstColor.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 18.w,
              height: 18.h,
              colorFilter: ColorFilter.mode(
                ConstColor.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            CustomText(
              title: label,
              textSize: 13.sp,
              fontWeight: FontWeight.w500,
              textColor: ConstColor.black,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}
