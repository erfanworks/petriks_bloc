import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../../VibeAllScreen/OneToOneMeetupDetailsScreen/Controller/one_to_one_meetup_details_controller.dart';
import 'Controller/plan_details_controller.dart';

class PlanMapScreen extends StatelessWidget {
  const PlanMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlanDetailsController>();

    // ─── Get selected location name ───────────────
    final locationName = controller.locationVotes
        .firstWhereOrNull((l) => l.isSelected)
        ?.name ?? controller.locationVotes.first.name;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(
        title: locationName,
        onBack: () {
          try {
            Get.find<PlanDetailsController>().hasNavigated.value = true;
          } catch (_) {}

          try {
            Get.find<OneToOneMeetupDetailsController>().hasNavigated.value = true;
          } catch (_) {}

          Get.back();
        },
      ),
      body: Stack(
        children: [
          // TODO: replace with google_maps_flutter widget
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 56.sp,
                  color: ConstColor.primaryColor,
                ),
                SizedBox(height: 12.h),
                CustomText(
                  title: locationName,
                  textColor: ConstColor.textColor,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  title: 'Tap below to open in Google Maps',
                  textColor: ConstColor.white,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16.h,
            left: 16.w,
            right: 16.w,
            child: CustomElevatedButton(
              onPressed: () async {
                final query = Uri.encodeComponent(locationName);

                final googleMapsUri = Uri.parse(
                  'google.navigation:q=$query',
                );

                if (await canLaunchUrl(googleMapsUri)) {
                  await launchUrl(googleMapsUri);
                } else {
                  final browserUri = Uri.parse(
                    'https://maps.google.com/?q=$query',
                  );
                  await launchUrl(
                    browserUri,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              color: ConstColor.primaryColor,
              height: 48,
              top: 0,
              left: 0,
              right: 0,
              buttonBorderRadius: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.navigation_outlined,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: 'Open in Google Maps',
                    textColor: Colors.white,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}