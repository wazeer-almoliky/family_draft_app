import 'package:get/get.dart';
import 'package:family/controller/login_controller.dart';
class LoginBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => LoginController(),fenix: true);
  }
}