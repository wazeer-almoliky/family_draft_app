import 'dart:developer';

import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/services/app_services.dart';

class DetailsViewController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  var user = "";
  int? id, familyID,price,catID;
  String? name;
  @override
  void onInit() {
  //   remoteState.serviceState.clear();
  //  remoteState.servicesState.clear();
    remoteState.photoState.clear();
    super.onInit();
    id = Get.arguments["id"];
    name = Get.arguments["name"];
    price = Get.arguments["price"];
    catID = Get.arguments["catID"];
    checkFromUser();
    fetchData();
    log(id.toString());
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      user = storage!.read("userType");
      familyID = storage!.read("familyID");
      update();
    }
  }

  void fetchData() async {
    
    //remoteState.isLoading(true);
    try {
      if (user == "ادمن") {
        final user =
            await remoteState.api.respone("${AppLinks.service}?op_type=select");
        if (user != null) {
          remoteState.serviceState
              .addAll(user.map((e) => Catagory.fromjson(e)).toList());
          remoteState.serviceState.refresh();
        }
      } else {
        final data =
            await remoteState.api.respone("${AppLinks.photo}?op_type=select&product_id=$id");
        if (data != null) {
          remoteState.photoState
              .addAll(data.map((e) => Photo.fromjson(e)).toList());
          remoteState.photoState.refresh();
          log("*********${remoteState.photoState}************");
        }
      }
    } finally {
      //remoteState.isLoading(false);
    }
  }
}
