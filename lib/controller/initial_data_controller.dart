import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';

class InitialDataControllrt extends GetxController {
  final remoteState = RemoteState();
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final initialDataKey = GlobalKey<FormState>();
  late String serviceID;
  int? userID;
  final storage = AppService.getStorage;
  @override
  void onInit() {
    super.onInit();
    fetchData();
    checkFromUser();
  }

  void login() async {
    if (initialDataKey.currentState!.validate()) {
      StatusRequest.loading;
   final data=await remoteState.api.request(AppLinks.givenService, {
        "op_type": "insert",
        "family_name": name.text,
        "family_address": address.text,
        "family_phone": phone.text,
        "user_id": userID.toString(),
      },label: "عملية الاضافة");
      log("DATA...$data");
      storage!.write("familyID", data![1]);
    }
  }

  TextEditingController listOfController(int index) {
    final controller = [name, address, phone];
    return controller[index];
  }

  void checkFromUser() async {
    if (storage!.read("userID") != null) {
      userID = storage!.read("userID");
      log("${storage!.read("userID")}");
      update();
    }
  }

  List<String> listOfDataService() {
    return remoteState.getNames(remoteState.serviceState);
  }

  void fetchData() async {
    remoteState.serviceState.clear();
    remoteState.isLoading(true);
    try {
      final response =
          await remoteState.api.respone("${AppLinks.service}?op_type=select");
      if (response != null) {
        remoteState.serviceState
            .addAll(response.map((e) => Catagory.fromjson(e)).toList());
        remoteState.serviceState.refresh();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }
}
