import 'package:family/view/screens/user_decided.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/utilities/services/app_services.dart';
class SettingController extends GetxController{
  var mainColor = 0xFF191828;
  var mainColor2 = 0xFFF1EAD8;
  final storage = AppService.getStorage;

  @override
  void onInit() {
    super.onInit();
    getPrimaryColor();
  }
  Future<void> changeColor(Color color) async {
    mainColor = color.value;
    storage!.write("primary",color.value);
    update();
  }
  Future<void> changeColor2(Color color) async {
    mainColor2 = color.value;
    storage!.write("secondary",color.value);
    update();
  }
  void getPrimaryColor()async{
    if(storage!.read("primary") !=null){
      mainColor= storage!.read("primary");
      update();
    }
    if(storage!.read("secondary") !=null){
      mainColor2= storage!.read("secondary");
      update();
    }
  }

  void relooad(){
    Get.reload();
    update();
    // Get.reloadAll(force: true);
  }
  void logout(){
    storage!.remove("userID");
    Get.offAll(()=>const UserDecided());
  }
}