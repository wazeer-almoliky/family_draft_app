import 'package:family/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/binding/dashboard_binding.dart';
import 'package:family/model/remote/api_data.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:family/utilities/functions/api_function.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/dashboard.dart';

class LoginController extends GetxController {
  final remoteState = RemoteState();
  final user = TextEditingController();
  final pass = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  final api = ApiData(Get.find<Crud>());
  final storageService = Get.find<AppService>();
  final storage = AppService.getStorage;
  bool isEnablePassword=true;
  void login() async {
    if (loginKey.currentState!.validate()) {
      StatusRequest.loading;
      final data = await remoteState.api.respone(
          "${AppLinks.user}?op_type=login&user_name=${user.text}&user_password=${pass.text}",isSignUp: true);
      if (data != null) {
        if (data.isEmpty) {
          CustomAlertDialog.showSnackBar(
              "تـأكد من اســم المستخــدم أو كلمـة المرور",
              size: 18,
              color: AppColors.red);
          return;
        }
        if (data[0]["user_state"] == 0) {
          CustomAlertDialog.showSnackBar(
              "اســم المستخـدم لم يتـم تفعليه بعـد!.",
              size: 18);
          return;
        }
        storage!.write("userType", data[0]["user_type"]);
        storage!.write("userName", data[0]["user_name"]);
        storage!.write("userID", data[0]["user_id"]);
        // storage!.write("familyID", 17);
        Future.delayed(const Duration(seconds: 2), () async {
          await navigateToLoginScreen();
        });
      }
    }
  }
  void enablePassword(){
    isEnablePassword=!isEnablePassword;
    update();
  }
  Future<void> navigateToLoginScreen() async {
    await Get.off(() => const Dashboard(),
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        transition: Transition.leftToRightWithFade,
        binding: DashboardBinding());
  }

  TextEditingController listOfController(int index) {
    final controller = [user, pass];
    return controller[index];
  }
}
