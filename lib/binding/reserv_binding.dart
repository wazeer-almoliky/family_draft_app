import 'package:get/get.dart';
import 'package:family/controller/reserve_controller.dart';

class ReserveBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ReserveController(),fenix: true);
  }
  
}