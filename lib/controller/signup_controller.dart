import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/binding/login_binding.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/view/screens/login_screen.dart';

class SignUpController extends GetxController {
  final remoteState = RemoteState();
  final user = TextEditingController();
  final pass = TextEditingController();
  final phone = TextEditingController();
  final signUpKey = GlobalKey<FormState>();
   bool isEnablePassword=true;
  void signUp() async {
    if (signUpKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "insert",
        "user_name": user.text,
        "user_type": "عادي",
        "user_password": pass.text,
        "user_phone": phone.text,
        "user_state": "0",
      },label: "عملية الاضافة");
      Future.delayed(const Duration(seconds: 3),()async{
        await navigateToLoginScreen();
      });
    }
  }
  void enablePassword(){
    isEnablePassword=!isEnablePassword;
    update();
  }
  Future<void> navigateToLoginScreen() async {
    await Get.off(() => const LoginScreen(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.downToUp,
        binding: LoginBinding());
  }

  TextEditingController listOfController(int index){
    final controller = [user,pass,phone];
    return controller[index];
  }
}
