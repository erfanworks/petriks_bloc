import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:petriks_flutter_app/widget/SupportReportService/support_report_service.dart';
import '../../../../../Widget/GlobalAppBar/global_app_bar.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';

class SupportHistoryScreen extends StatelessWidget {
  const SupportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SupportReportService.to;

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(title: 'My Reports'),
      body: Obx(() {
        final list = service.reports;
        if (list.isEmpty) {
          return Center(
            child: CustomText(
              title: "You haven't submitted any reports yet.",
              textSize: 14.sp,
              textColor: ConstColor.grey,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemCount: list.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (_, i) => _ReportTile(report: list[i]),
        );
      }),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.report});
  final SupportReport report;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        _ReportDetailSheet(report: report),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      ),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: report.subject,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textColor: ConstColor.black,
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: report.formattedDate,
                    textSize: 12.sp,
                    textColor: ConstColor.grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _StatusChip(status: report.status, label: report.statusLabel),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.label});
  final SupportStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      SupportStatus.pending => (const Color(0xFFFFEDD5), const Color(0xFFEA8C00)),
      SupportStatus.underReview => (const Color(0xFFE7EEFF), const Color(0xFF2765EB)),
      SupportStatus.resolved => (const Color(0xFFE8F7EE), const Color(0xFF15803D)),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        title: label,
        textSize: 11.sp,
        fontWeight: FontWeight.w700,
        textColor: fg,
        maxLine: 1,
      ),
    );
  }
}

class _ReportDetailSheet extends StatelessWidget {
  const _ReportDetailSheet({required this.report});
  final SupportReport report;

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(top: 14.h, bottom: 4.h),
        child: CustomText(
          title: t,
          textSize: 12.sp,
          fontWeight: FontWeight.w600,
          textColor: ConstColor.grey,
          maxLine: 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ConstColor.borderColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      title: 'Report Details',
                      textSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      textColor: ConstColor.black,
                      maxLine: 1,
                    ),
                  ),
                  _StatusChip(status: report.status, label: report.statusLabel),
                ],
              ),
              _label('Reference'),
              CustomText(title: report.id, textSize: 14.sp, textColor: ConstColor.black, maxLine: 1),
              _label('Submitted'),
              CustomText(title: report.formattedDate, textSize: 14.sp, textColor: ConstColor.black, maxLine: 1),
              _label('Subject'),
              CustomText(title: report.subject, textSize: 14.sp, fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 3),
              _label('Description'),
              CustomText(title: report.description, textSize: 14.sp, textColor: ConstColor.textColor, maxLine: 50),
            ],
          ),
        ),
      ),
    );
  }
}
