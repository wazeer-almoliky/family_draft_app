import 'package:get/get.dart';
import 'package:family/controller/services_controller.dart';

class ServiceBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ServicesController(),fenix: true);
  }
  
}