import 'package:get/get.dart';

enum SupportStatus { pending, underReview, resolved }

class SupportReport {
  final String id, subject, description;
  final DateTime submittedAt;
  final SupportStatus status;

  const SupportReport({
    required this.id,
    required this.subject,
    required this.description,
    required this.submittedAt,
    this.status = SupportStatus.pending,
  });

  String get statusLabel => switch (status) {
        SupportStatus.pending => 'Pending',
        SupportStatus.underReview => 'Under Review',
        SupportStatus.resolved => 'Resolved',
      };

  String get formattedDate {
    const m = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final h = submittedAt.hour % 12 == 0 ? 12 : submittedAt.hour % 12;
    final min = submittedAt.minute.toString().padLeft(2, '0');
    final p = submittedAt.hour < 12 ? 'AM' : 'PM';
    return '${submittedAt.day} ${m[submittedAt.month - 1]} ${submittedAt.year}, $h:$min $p';
  }
}

class SupportReportService extends GetxService {
  static SupportReportService get to => Get.isRegistered<SupportReportService>()
      ? Get.find<SupportReportService>()
      : Get.put(SupportReportService(), permanent: true);

  // TODO(API): sample data মুছে API থেকে আনবেন (status ব্যাকএন্ড থেকে আপডেট হবে)
  final RxList<SupportReport> reports = <SupportReport>[
    SupportReport(
      id: 'GN-10482',
      subject: 'Payment issue when boosting a plan',
      description:
          'I was charged £1.99 but the boost did not appear on my plan. Please check my payment.',
      submittedAt: DateTime.now().subtract(const Duration(days: 1)),
      status: SupportStatus.underReview,
    ),
    SupportReport(
      id: 'GN-10311',
      subject: 'Unable to edit competition title',
      description: 'The title field would not let me type when editing my competition.',
      submittedAt: DateTime.now().subtract(const Duration(days: 6)),
      status: SupportStatus.resolved,
    ),
  ].obs;

  void add({required String subject, required String description}) {
    final stamp = (DateTime.now().millisecondsSinceEpoch % 100000)
        .toString()
        .padLeft(5, '0');
    reports.insert(
      0,
      SupportReport(
        id: 'GN-$stamp',
        subject: subject,
        description: description,
        submittedAt: DateTime.now(),
      ),
    );
  }
}
