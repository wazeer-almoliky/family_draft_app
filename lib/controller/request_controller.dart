import 'dart:developer';

import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';

class ResquestController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  int? userState, userID,familyID;
  var admin = "";
  @override
  void onInit() {
    super.onInit();
    checkFromUser();
    fetchData();
    userState = Get.arguments["userState"];
  }

  void fetchData() async {
    // remoteState.userState.clear();
    // remoteState.reserveState.clear();
    // remoteState.isLoading(true);
    try {
      if(admin=="ادمن"){
        final resp1 =
          await remoteState.api.respone("${AppLinks.user}?op_type=select");
      if (resp1 != null) {
        remoteState.userState
            .addAll(resp1.map((e) => User.fromjson(e)).toList());
        remoteState.userState.refresh();
      }
      }
      else{
        log("00001");
        final resp =userState==0? await remoteState.api
          .respone("${AppLinks.reserve}?op_type=selectdisable&family_id=$familyID")
          :await remoteState.api.respone("${AppLinks.reserve}?op_type=select&family_id=$familyID");
      if (resp != null) {
        remoteState.reserveState
            .addAll(resp.map((e) => Reserve.fromjson(e)).toList());
        remoteState.reserveState.refresh();
         log("10000");
      }
     
      }
      
      // log("000$admin");
    } finally {
      remoteState.isLoading(false);
    }
  }

  void updateData(int reserveID) async {
    log("$reserveID>>");
    StatusRequest.loading;
    await remoteState.api.request(AppLinks.reserve, {
      "op_type": "update",
      "request_status": 1.toString(),
      "request_id": reserveID.toString(),
    },label: "عملية القبول والتأكيد");
    update();
    fetchData();
  }

  void updateUser(int userID, {int? disableUser,String? hint}) async {
    StatusRequest.loading;
    remoteState.api.request(AppLinks.user, {
      "op_type": "update2",
      "user_state": disableUser.toString(),
      "user_id": userID.toString(),
    },label:"عملية $hint ");
    update();
    fetchData();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      familyID = storage!.read("familyID");
      update();
    }
    log("FFF>>>$familyID");
  }
}
