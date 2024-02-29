import 'package:get/get.dart';
import 'package:family/controller/signup_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() =>  SignUpController(),fenix: true);
  }
  
}