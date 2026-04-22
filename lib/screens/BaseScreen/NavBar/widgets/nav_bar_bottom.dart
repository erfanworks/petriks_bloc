import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/const_color.dart';

class NavBarBottom extends StatelessWidget {
  const NavBarBottom({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  // ── Tab config ──
  static const _tabs = [
    {'label': 'HOME',    'icon': 'assets/icons/ic_home.svg'},
    {'label': 'MY PLAN', 'icon': 'assets/icons/ic_my_plan.svg'},
    {'label': '',        'icon': ''},   // center + button
    {'label': 'MESSAGE', 'icon': 'assets/icons/ic_message.svg'},
    {'label': 'PROFILE', 'icon': 'assets/icons/ic_profile.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

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
          // ── Center + button ──
          if (i == 2) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                child: Center(
                  child: Container(
                    width: 54.r,
                    height: 54.r,
                    margin: EdgeInsets.only(bottom: bottomPad),
                    decoration: const BoxDecoration(
                      color: ConstColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28.r,
                    ),
                  ),
                ),
              ),
            );
          }

          // ── Normal tab ──
          final isSelected = selectedIndex == i;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(i),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _tabs[i]['icon']!,
                      width: 24.r,
                      height: 24.r,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _tabs[i]['label']!,
                      style: TextStyle(
                        color: isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.iconColor,
                        fontSize: 10.sp,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}