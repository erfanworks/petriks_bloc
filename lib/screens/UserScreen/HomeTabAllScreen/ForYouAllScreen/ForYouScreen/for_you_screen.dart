import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Controller/one_to_one_meetup_controller.dart';
import '../../VibeAllScreen/OneToOneMeetupScreen/Widget/one_to_one_meetup_card.dart';
import 'Controller/for_you_controller.dart';
import 'Widget/featured_event_card.dart';
import 'Widget/people_card.dart';
import 'Widget/upcoming_event_card.dart';

class ForYouScreen extends StatelessWidget {
  const ForYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForYouController>();

    return SingleChildScrollView(
      key: const PageStorageKey('for_you_scroll_key'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const FeaturedEventCard(),
          ),

          SizedBox(height: 20.h),

          _InviteFriendsButton(controller: controller),

          SizedBox(height: 20.h),

          _SectionHeader(title: ConstString.easyMeetup, showSeeAll: false),

          SizedBox(height: 12.h),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: Get.find<OneToOneMeetupController>().meetups.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (_, index) => OneToOneMeetupCard(
              item: Get.find<OneToOneMeetupController>().meetups[index],
            ),
          ),

          SizedBox(height: 20.h),
          _SectionHeader(
            title: ConstString.peopleYouMayClick,
            showSeeAll: false,
            onSeeAll: controller.onSeeAllPeople,
          ),

          SizedBox(height: 12.h),
          SizedBox(
            height: 240.h,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w, right: 22.w),
                itemCount: controller.people.length,
                separatorBuilder: (_, _) => SizedBox(width: 5.w),
                itemBuilder: (_, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: PeopleCard(item: controller.people[index]),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24.h),

          _SectionHeader(
            title: ConstString.upcomingEvents,
            showSeeAll: false,
            onSeeAll: controller.onSeeAllEvents,
          ),

          SizedBox(height: 12.h),

          SizedBox(
            height: 460.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.w, right: 32.w),
              itemCount: controller.upcomingEvents.length,
              separatorBuilder: (_, _) => SizedBox(width: 12.w),
              itemBuilder: (_, index) => SizedBox(
                width: MediaQuery.of(context).size.width - 60.w,
                child: UpcomingEventCard(
                  item: controller.upcomingEvents[index],
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _InviteFriendsButton extends StatefulWidget {
  final ForYouController controller;

  const _InviteFriendsButton({required this.controller});

  @override
  State<_InviteFriendsButton> createState() => _InviteFriendsButtonState();
}

class _InviteFriendsButtonState extends State<_InviteFriendsButton>
    with TickerProviderStateMixin {
  late final AnimationController _floatCtrl;
  late final Animation<double> _floatAnim;

  late final AnimationController _shimmerCtrl;
  late final Animation<double> _shimmerAnim;

  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;

  static const _inviteLink = 'https://goodniva.app/invite?ref=USER_REF_CODE';
  static const _inviteText =
      'Join me on GoodNiva — discover local meetups & events! 🎉\n$_inviteLink';

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));

    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _shimmerAnim = Tween<double>(
      begin: -1.5,
      end: 2.5,
    ).animate(CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut));

    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1.0,
    );

    _scaleAnim = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _shimmerCtrl.dispose();
    _scaleCtrl.dispose();
    super.dispose();
  }

  Future<void> _onTap(BuildContext context) async {
    await _scaleCtrl.reverse();
    await _scaleCtrl.forward();

    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(
        text: _inviteText,
        subject: 'Join GoodNiva!',
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatAnim, _scaleAnim, _shimmerAnim]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnim.value),
            child: Transform.scale(
              scale: _scaleAnim.value,
              child: GestureDetector(
                onTap: () => _onTap(context),
                child: CustomPaint(
                  painter: _ShimmerBorderPainter(
                    progress: _shimmerAnim.value,
                    borderColor: ConstColor.primaryColor.withAlpha(50),
                    shimmerColor: ConstColor.primaryColor.withAlpha(180),
                    radius: 30.r,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                color: ConstColor.primaryColor,
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: CustomText(
                  title: ConstString.inviteFriendsBoots,
                  textColor: ConstColor.primaryColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ),
              SizedBox(width: 10.w),
              Image.asset("assets/images/bossts_img.png"),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBorderPainter extends CustomPainter {
  final double progress;
  final Color borderColor;
  final Color shimmerColor;
  final double radius;

  const _ShimmerBorderPainter({
    required this.progress,
    required this.borderColor,
    required this.shimmerColor,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final basePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(rRect, basePaint);

    final shimmerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [Colors.transparent, shimmerColor, Colors.transparent],
        stops: const [0.0, 0.5, 1.0],
        begin: Alignment(progress - 1, -0.5),
        end: Alignment(progress, 0.5),
      ).createShader(rect);

    canvas.drawRRect(rRect, shimmerPaint);
  }

  @override
  bool shouldRepaint(_ShimmerBorderPainter old) => old.progress != progress;
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool showSeeAll;
  final VoidCallback? onSeeAll;

  const _SectionHeader({
    required this.title,
    this.showSeeAll = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: title,
            textColor: ConstColor.black,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
            fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          ),
          if (showSeeAll)
            GestureDetector(
              onTap: onSeeAll,
              child: CustomText(
                title: ConstString.seeAll,
                textColor: ConstColor.primaryColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
        ],
      ),
    );
  }
}
