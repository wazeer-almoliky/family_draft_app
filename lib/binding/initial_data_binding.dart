import 'package:get/get.dart';
import 'package:family/controller/initial_data_controller.dart';

class InitialData extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialDataControllrt(),fenix: true);
  }
  
}