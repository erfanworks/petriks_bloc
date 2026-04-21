
import 'package:get/get.dart';
import 'package:getX_template_2026/service/SocketService/socket_service.dart';
Future<void> init() async {

  // ================(SocketService) ================
  await Get.putAsync<SocketService>(() async {
    final service = SocketService();
    await service.init();
    return service;
  });
}
