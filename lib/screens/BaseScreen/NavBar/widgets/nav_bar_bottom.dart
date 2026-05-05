import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constant/const_color.dart';
import '../controller/navbar_controller.dart';

class NavBarBottom extends StatelessWidget {
  const NavBarBottom({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  static const _tabs = [
    {'label': 'HOME',    'icon': 'assets/icons/home_icon.svg'},
    {'label': 'MY PLAN', 'icon': 'assets/icons/my_plan_icon.svg'},
    {'label': '',        'icon': 'assets/icons/add_icon.svg'},
    {'label': 'MESSAGE', 'icon': 'assets/icons/message_icon.svg'},
    {'label': 'PROFILE', 'icon': 'assets/icons/profile_icon2.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPad     = MediaQuery.of(context).padding.bottom;
    final navController = Get.find<NavbarController>();

    return Container(
      height: 72.h + bottomPad,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 20.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          if (i == 2) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                child: Center(
                  child: Container(
                    width: 54.r,
                    height: 54.r,
                    margin: EdgeInsets.only(bottom: bottomPad),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ConstColor.primaryDeepColor.withAlpha(50),
                          blurRadius: 60.r,
                          spreadRadius: 20.r,
                        ),
                      ],
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 28.r),
                  ),
                ),
              ),
            );
          }

          final isSelected = selectedIndex == i;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPad),
                child: i == 1
                    ? Obx(() => _MyPlanTab(
                  isSelected: isSelected,
                  isGlowing: navController.isMyPlanHighlighted.value,
                ))
                    : _TabItem(
                  icon: _tabs[i]['icon']!,
                  label: _tabs[i]['label']!,
                  isSelected: isSelected,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── MY PLAN tab with multi-ring pulse ──
class _MyPlanTab extends StatefulWidget {
  const _MyPlanTab({required this.isSelected, required this.isGlowing});
  final bool isSelected, isGlowing;

  @override
  State<_MyPlanTab> createState() => _MyPlanTabState();
}

class _MyPlanTabState extends State<_MyPlanTab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    if (widget.isGlowing) _ctrl.repeat();
  }

  @override
  void didUpdateWidget(_MyPlanTab old) {
    super.didUpdateWidget(old);
    if (widget.isGlowing && !_ctrl.isAnimating) {
      _ctrl.repeat();
    } else if (!widget.isGlowing && _ctrl.isAnimating) {
      _ctrl.stop();
      _ctrl.reset();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.isSelected;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // 3 staggered rings
        if (widget.isGlowing) ...[
          _PulseRing(controller: _ctrl, delay: 0.0,  maxRadius: 36.r),
          _PulseRing(controller: _ctrl, delay: 0.35, maxRadius: 44.r),
          _PulseRing(controller: _ctrl, delay: 0.65, maxRadius: 52.r),
        ],

        // Icon + label
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/my_plan_icon.svg',
              width: 24.r,
              height: 24.r,
              colorFilter: ColorFilter.mode(
                active ? ConstColor.primaryColor : ConstColor.iconColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'MY PLAN',
              style: TextStyle(
                color:      active ? ConstColor.primaryColor : ConstColor.iconColor,
                fontSize:   11.sp,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({
    required this.controller,
    required this.delay,
    required this.maxRadius,
  });

  final AnimationController controller;
  final double delay;
  final double maxRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final t = ((controller.value + delay) % 1.0);

        final radius  = maxRadius * t;
        final opacity = (1.0 - t).clamp(0.0, 1.0);

        return Container(
          width:  radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ConstColor.primaryColor.withAlpha((opacity * 80).toInt()),
              width: 1.5,
            ),
          ),
        );
      },
    );
  }
}

// ── Normal tab ──
class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  final String icon, label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          width: 24.r,
          height: 24.r,
          colorFilter: ColorFilter.mode(
            isSelected ? ConstColor.primaryColor : ConstColor.iconColor,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color:      isSelected ? ConstColor.primaryColor : ConstColor.iconColor,
            fontSize:   11.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}