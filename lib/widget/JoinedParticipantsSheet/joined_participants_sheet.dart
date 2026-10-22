import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/const_color.dart';
import '../AppImage/app_image.dart';
import '../text/custom_text.dart';

class JoinedParticipant {
  final String name;
  final String image;
  const JoinedParticipant({required this.name, required this.image});
}

class JoinedParticipantsSheet extends StatelessWidget {
  final List<JoinedParticipant> participants;
  final int? maxCount;

  const JoinedParticipantsSheet({
    super.key,
    required this.participants,
    this.maxCount,
  });

  static Future<void> show({
    required List<JoinedParticipant> participants,
    int? maxCount,
  }) {
    return Get.bottomSheet(
      JoinedParticipantsSheet(participants: participants, maxCount: maxCount),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = maxCount != null
        ? '${participants.length}/$maxCount'
        : '${participants.length}';

    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ConstColor.borderColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Row(
                children: [
                  CustomText(
                    title: 'Joined',
                    textSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: '($count)',
                    textSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textColor: ConstColor.primaryColor,
                    maxLine: 1,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close_rounded,
                        color: ConstColor.black, size: 22.r),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 20.h),
                itemCount: participants.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (_, i) {
                  final p = participants[i];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5FA),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: AppImage(
                            path: p.image,
                            width: 40.r,
                            height: 40.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomText(
                            title: p.name,
                            textSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            textColor: ConstColor.black,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
