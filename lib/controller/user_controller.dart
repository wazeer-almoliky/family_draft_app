import 'package:family/app_links.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserController extends GetxController{
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
    fetchData();
    super.onInit();
    // label=Get.arguments["label"];
    // userID2=Get.arguments["userID"];
  }
  void fetchData()async{
    remoteState.userState.clear();
    // remoteState.isLoading(true);
    try {
      final data = await remoteState.api.respone(
          "${AppLinks.user}?op_type=select");
      if (data != null) {
        remoteState.userState.addAll(data.map((e) => User.fromjson(e)).toList());
        remoteState.userState.refresh();
      } 
    } finally {
       remoteState.isLoading(false);
    }
  }

  TextEditingController listOfController(int index){
    final controller = [user,pass];
    return controller[index];
  }

  void updateUser(int id102) async {
    if (userKey.currentState!.validate()) {
      StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "update",
        "user_name": user.text,
        "user_type": "ادمن",
        "user_password": pass.text,
        "user_state": "1",
        "user_id": "$id102",
      });
    }
    user.text="";
    pass.text="";
    fetchData();
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
    fetchData();
  }
  void deleteUser(int id101) async {
    StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "delete",
         "user_id": "$id101",
      },label: "عملية الحذف");
  }
  void stopUser(int id101) async {
    StatusRequest.loading;
      remoteState.api.request(AppLinks.user, {
        "op_type": "update2",
         "user_id": "$id101",
         "user_state": "0",
      },label: "عملية الإيقــاف");
  }
  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }
}