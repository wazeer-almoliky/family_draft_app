import 'package:get/get.dart';
import 'package:family/controller/section_service_cpntroller.dart';

class SectionServiceBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SectionServiceController(),fenix: true);
  }
  
}