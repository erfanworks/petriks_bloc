import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/routes/app_routes/app_routes.dart';
import 'package:petriks_flutter_app/screens/UserScreen/HomeTabAllScreen/CommunityAllScreen/MyGroupDetailScreen/Controller/edit_group_controller.dart';
import 'package:petriks_flutter_app/widget/GlobalAppBar/global_app_bar.dart';
import 'package:petriks_flutter_app/widget/GroupDetailWidgets/group_detail_widgets.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';

class MyGroupDetailScreen extends StatelessWidget {
  const MyGroupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyGroupController>();
    final args = ModalRoute.of(context)?.settings.arguments;
    final bool canManage = args is Map && args['canManage'] == true;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: GlobalAppBar(
        title: ConstString.groupDetails,
        actions: [
          canManage
              ? PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert, color: ConstColor.black),
                  offset: const Offset(-10, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 1) {
                      controller.onEditGroup();
                    } else if (value == 2) {
                      controller.onDeleteGroup();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: CustomText(
                        title: ConstString.editGroup,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(
                      value: 2,
                      child: CustomText(
                        title: ConstString.deleteGroup,
                        textColor: ConstColor.black,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const GroupHeaderWidget(),
            SizedBox(height: 16.h),
            const GroupAboutCard(),
            SizedBox(height: 12.h),
            const GroupProgressCard(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: CustomElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.inviteFriendsListScreen);
          },
          height: 50,
          top: 0,
          buttonBorderRadius: 30,
          gradient: [ConstColor.primaryDeepColor, ConstColor.primaryColor],
          child: CustomText(
            title: ConstString.inviteFriends,
            textColor: Colors.white,
            textSize: 16.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}
