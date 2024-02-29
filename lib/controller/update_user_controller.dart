import 'package:family/app_links.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UpdateUserController extends GetxController{
  final remoteState = RemoteState();
   final storage = AppService.getStorage;
  final user = TextEditingController();
  final pass = TextEditingController();
  final userKey = GlobalKey<FormState>();
  var admin = "";
  String? label;
  int? userID,userID2;
  @override
  void onInit() {
    checkFromUser();
   
    super.onInit();
    label=Get.arguments["label"];
    userID2=Get.arguments["userID"];
    user.text=Get.arguments["name"]??"";
  }
  

  TextEditingController listOfController(int index){
    final controller = [user,pass];
    return controller[index];
  }

  void updateUser() async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "update",
        "user_name": user.text,
        "user_type": "ادمن",
        "user_password": pass.text,
        "user_state": "1",
        "user_id": "$userID2",
      },label: "عملية التعديل");
    }
    user.text="";
    pass.text="";

  }
  void addUser() async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "insert",
        "user_name": user.text,
        "user_type": "ادمن",
        "user_password": pass.text,
        "user_phone": "",
        "user_state": "1",
      },label: "عملية الاضافة");
    }
    user.text="";
    pass.text="";
   
  }
  void deleteUser(int id101) async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "delete",
         "user_id": "$id101",
      },label: "عملية الحذف");
    }
  }
  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }
}