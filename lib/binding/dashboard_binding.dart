import 'package:get/get.dart';
import 'package:family/controller/dashboard_controller.dart';
class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController(),fenix: true);
  }
  
}