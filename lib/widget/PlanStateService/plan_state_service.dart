import 'package:get/get.dart';

class PlanStateService extends GetxService {
  static PlanStateService get to => Get.isRegistered<PlanStateService>()
      ? Get.find<PlanStateService>()
      : Get.put(PlanStateService(), permanent: true);

  // TODO(API): joined অবস্থা ও lock সময় API থেকে আসবে
  final Set<String> _joined = {};
  final Map<String, DateTime> _lockUntil = {};

  bool isJoined(String key) => _joined.contains(key);
  void markJoined(String key) => _joined.add(key);

  // প্রথমবার খুললে lock সময় ঠিক হয়, পরে একই সময় ফেরত আসে
  DateTime lockUntilFor(String key, Duration fallback) =>
      _lockUntil.putIfAbsent(key, () => DateTime.now().add(fallback));
}
