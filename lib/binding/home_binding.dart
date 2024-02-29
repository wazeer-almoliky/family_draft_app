import 'package:get/get.dart';
import 'package:family/controller/home_controller.dart';
class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),fenix: true);
  }
  
}