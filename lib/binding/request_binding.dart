import 'package:get/get.dart';
import 'package:family/controller/request_controller.dart';

class RequestBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ResquestController(),fenix: true);
  }
  
}