









//////////////////////////////This screen is no navigation/////////





// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../../../../Widget/text/custom_text.dart';
// import '../../../../../constant/const_color.dart';
// import '../../../../../constant/const_string.dart';
// import '../../../../../widget/AppImage/app_image.dart';
// import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
// import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
// import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
// import '../Controller/my_plan_controller.dart';
// import 'created_plan_details_screen.dart';
//
// // Edit Plan Screen
//
//
// // ─────────────────────────────────────────
// // Joined Plan Details Screen
// // (2 states: joinable & completed — based on plan.tag)
// // ─────────────────────────────────────────
// class JoinedPlanDetailsScreen extends StatelessWidget {
//   const JoinedPlanDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final plan = Get.arguments as PlanModel;
//     final isCompleted = plan.tag == 'COMPLETED';
//
//     return Scaffold(
//       backgroundColor: ConstColor.backgroundColor,
//       appBar: GlobalAppBar(title: ConstString.planDetails),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Shared header
//                   PlanDetailHeader(
//                     plan: plan,
//                     statusTag: isCompleted ? 'COMPLETED' : null,
//                   ),
//                   SizedBox(height: 14.h),
//
//                   if (isCompleted)
//                     _CompletedContent(plan: plan)
//                   else
//                     _JoinableContent(plan: plan),
//                 ],
//               ),
//             ),
//           ),
//
//           // Bottom button
//           Padding(
//             padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
//             child: CustomElevatedButton(
//               top: 0,
//               onPressed: () {},
//               color: ConstColor.primaryColor,
//               buttonBorderRadius: 30,
//               child: CustomText(
//                 title: isCompleted
//                     ? ConstString.createAgain
//                     : ConstString.joinEvent,
//                 textSize: 15.sp,
//                 fontWeight: FontWeight.w600,
//                 textColor: Colors.white,
//                 maxLine: 1,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Joinable state content ──
// class _JoinableContent extends StatelessWidget {
//   const _JoinableContent({required this.plan});
//   final PlanModel plan;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Choose Time
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.chooseTime),
//               SizedBox(height: 10.h),
//               ...[
//                 {'label': 'Sat • 7:30 PM', 'votes': '4 Vote'},
//                 {'label': 'Sat • 7:30 PM', 'votes': '2 Vote'},
//               ].map((t) => _VoteOptionRow(
//                 icon: 'assets/icons/ic_calendar.svg',
//                 label: t['label']!,
//                 votes: t['votes']!,
//               )),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Choose Place
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.choosePlace),
//               SizedBox(height: 10.h),
//               ...[
//                 {'label': 'Central Park West', 'votes': '4 Vote'},
//                 {'label': 'Dhanmondi Lake', 'votes': '2 Vote'},
//               ].map((p) => _VoteOptionRow(
//                 icon: 'assets/icons/ic_location_pin.svg',
//                 label: p['label']!,
//                 votes: p['votes']!,
//               )),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Group Chat (locked)
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.groupChat),
//               SizedBox(height: 10.h),
//               _LockedChatWidget(),
//               SizedBox(height: 14.h),
//               // Captain row
//               _CaptainRow(),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Safety First
//         _SectionPad(
//           child: Row(
//             children: [
//               SvgPicture.asset('assets/icons/ic_shield.svg',
//                   width: 20.r, height: 20.r,
//                   colorFilter: const ColorFilter.mode(
//                       ConstColor.primaryColor, BlendMode.srcIn)),
//               SizedBox(width: 10.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       title: ConstString.safetyFirst,
//                       textSize: 13.sp,
//                       fontWeight: FontWeight.w700,
//                       textColor: ConstColor.black,
//                       maxLine: 1,
//                     ),
//                     CustomText(
//                       title: ConstString.safetySubtitle,
//                       textSize: 11.sp,
//                       textColor: ConstColor.iconColor,
//                       maxLine: 3,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//       ],
//     );
//   }
// }
//
// // ── Completed state content ──
// class _CompletedContent extends StatelessWidget {
//   const _CompletedContent({required this.plan});
//   final PlanModel plan;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Summary stats
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.hereWhatPeopleShared),
//               SizedBox(height: 12.h),
//               Row(
//                 children: [
//                   _StatCard(emoji: '😊', label: 'Over All Vibe', value: 'Good'),
//                   SizedBox(width: 8.w),
//                   _StatCard(emoji: '👥', label: 'Attended', value: '4 People'),
//                   SizedBox(width: 8.w),
//                   _StatCard(emoji: '⭐', label: 'Positive', value: '80%'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Overall feelings
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.overallFeelings),
//               SizedBox(height: 12.h),
//               ...[
//                 {'emoji': '⚡', 'label': 'Electric', 'value': 2, 'max': 6},
//                 {'emoji': '😌', 'label': 'Chill',    'value': 2, 'max': 6},
//                 {'emoji': '🔥', 'label': 'Unreal',   'value': 0, 'max': 6},
//                 {'emoji': '😬', 'label': 'Awkward',  'value': 0, 'max': 6},
//                 {'emoji': '😐', 'label': 'Boring',   'value': 0, 'max': 6},
//               ].map((f) => _FeelingBar(
//                 emoji: f['emoji'] as String,
//                 label: f['label'] as String,
//                 value: f['value'] as int,
//                 max: f['max'] as int,
//               )),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//
//         // Who joined
//         _SectionPad(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionTitle(title: ConstString.whoJoined),
//               SizedBox(height: 12.h),
//               Row(
//                 children: List.generate(
//                   4,
//                       (i) => Padding(
//                     padding: EdgeInsets.only(right: 6.w),
//                     child: ClipOval(
//                       child: AppImage(
//                         path: 'assets/images/avatar_${i + 1}.png',
//                         width: 40.r,
//                         height: 40.r,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 16.h),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────
// // Shared small widgets
// // ─────────────────────────────────────────
// class _SectionPad extends StatelessWidget {
//   const _SectionPad({required this.child});
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) => Container(
//     width: double.infinity,
//     margin: EdgeInsets.symmetric(horizontal: 16.w),
//     padding: EdgeInsets.all(14.r),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16.r),
//     ),
//     child: child,
//   );
// }
//
// class _SectionTitle extends StatelessWidget {
//   const _SectionTitle({required this.title});
//   final String title;
//
//   @override
//   Widget build(BuildContext context) => CustomText(
//     title: title,
//     textSize: 15.sp,
//     fontWeight: FontWeight.w700,
//     textColor: ConstColor.black,
//     maxLine: 1,
//   );
// }
//
//
//
// class _VoteOptionRow extends StatelessWidget {
//   const _VoteOptionRow({required this.icon, required this.label, required this.votes});
//   final String icon, label, votes;
//
//   @override
//   Widget build(BuildContext context) => Container(
//     margin: EdgeInsets.only(bottom: 8.h),
//     padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
//     decoration: BoxDecoration(
//       color: ConstColor.backgroundColor,
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: Row(
//       children: [
//         SvgPicture.asset(icon,
//             width: 14.r, height: 14.r,
//             colorFilter: const ColorFilter.mode(
//                 ConstColor.primaryColor, BlendMode.srcIn)),
//         SizedBox(width: 8.w),
//         Expanded(
//           child: CustomText(title: label, textSize: 13.sp,
//               fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
//         ),
//         CustomText(title: votes, textSize: 11.sp,
//             textColor: ConstColor.iconColor, maxLine: 1),
//       ],
//     ),
//   );
// }
//
// class _LockedChatWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Container(
//     height: 90.h,
//     decoration: BoxDecoration(
//       color: ConstColor.backgroundColor,
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.lock_outline_rounded,
//             size: 22.r, color: ConstColor.primaryColor),
//         SizedBox(height: 6.h),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//           decoration: BoxDecoration(
//             color: ConstColor.primaryColor.withAlpha(30),
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Column(
//             children: [
//               CustomText(title: ConstString.joinToUnlockChat,
//                   textSize: 12.sp, fontWeight: FontWeight.w700,
//                   textColor: ConstColor.black, textAlign: TextAlign.center, maxLine: 1),
//               CustomText(title: ConstString.joinToUnlockSubtitle,
//                   textSize: 11.sp, textColor: ConstColor.iconColor,
//                   textAlign: TextAlign.center, maxLine: 2),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// class _CaptainRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Row(
//     children: [
//       ClipOval(
//         child: AppImage(
//           path: 'assets/images/avatar_1.png',
//           width: 36.r, height: 36.r, fit: BoxFit.cover,
//         ),
//       ),
//       SizedBox(width: 8.w),
//       CustomText(title: 'Marcus Chen', textSize: 13.sp,
//           fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
//       SizedBox(width: 6.w),
//       Container(
//         padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//         decoration: BoxDecoration(
//           color: ConstColor.primaryColor.withAlpha(20),
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         child: CustomText(title: ConstString.captain, textSize: 9.sp,
//             fontWeight: FontWeight.w700, textColor: ConstColor.primaryColor, maxLine: 1),
//       ),
//       const Spacer(),
//       CustomElevatedButton(
//         top: 0, width: 100, height: 34,
//         onPressed: () => Get.toNamed('/host-profile'),
//         isOutLined: true,
//         outLineColour: ConstColor.primaryColor,
//         buttonBorderRadius: 20,
//         child: CustomText(title: ConstString.viewProfile, textSize: 11.sp,
//             fontWeight: FontWeight.w600, textColor: ConstColor.primaryColor, maxLine: 1),
//       ),
//     ],
//   );
// }
//
// class _StatCard extends StatelessWidget {
//   const _StatCard({required this.emoji, required this.label, required this.value});
//   final String emoji, label, value;
//
//   @override
//   Widget build(BuildContext context) => Expanded(
//     child: Container(
//       padding: EdgeInsets.all(10.r),
//       decoration: BoxDecoration(
//         color: ConstColor.backgroundColor,
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         children: [
//           Text(emoji, style: TextStyle(fontSize: 20.sp)),
//           SizedBox(height: 4.h),
//           CustomText(title: label, textSize: 10.sp,
//               textColor: ConstColor.iconColor, textAlign: TextAlign.center, maxLine: 1),
//           CustomText(title: value, textSize: 12.sp,
//               fontWeight: FontWeight.w700, textColor: ConstColor.primaryColor,
//               textAlign: TextAlign.center, maxLine: 1),
//         ],
//       ),
//     ),
//   );
// }
//
// class _FeelingBar extends StatelessWidget {
//   const _FeelingBar({required this.emoji, required this.label,
//     required this.value, required this.max});
//   final String emoji, label;
//   final int value, max;
//
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: EdgeInsets.only(bottom: 10.h),
//     child: Row(
//       children: [
//         Text(emoji, style: TextStyle(fontSize: 14.sp)),
//         SizedBox(width: 8.w),
//         SizedBox(
//           width: 60.w,
//           child: CustomText(title: label, textSize: 12.sp,
//               textColor: ConstColor.black, maxLine: 1),
//         ),
//         Expanded(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(4.r),
//             child: LinearProgressIndicator(
//               value: max == 0 ? 0 : value / max,
//               minHeight: 6.h,
//               backgroundColor: ConstColor.borderColor,
//               valueColor: const AlwaysStoppedAnimation(ConstColor.primaryColor),
//             ),
//           ),
//         ),
//         SizedBox(width: 8.w),
//         CustomText(title: '$value', textSize: 12.sp,
//             fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1),
//       ],
//     ),
//   );
// }