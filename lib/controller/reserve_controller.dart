import 'dart:developer';

import 'package:family/app_links.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReserveController extends GetxController {
   final storage = AppService.getStorage;
  //int? id;
  String? name1,customerName,customerPhone;
  final remoteState = RemoteState();
  final reserveKey = GlobalKey<FormState>();
  final
      date = TextEditingController(),
      count = TextEditingController();
  final listOfPayment = ["كــاش", "حســاب"];
  final listOfDropBoxValue = ["", ""];
  @override
  void onInit() {
    checkFromUser();
    // id = Get.arguments["id"];
    // name1 = Get.arguments["name"];
    super.onInit();
    
  }



  void request(int id,int price) async {
    // checkFromUser();
    if (reserveKey.currentState!.validate()) {
      final data={
        "op_type": "insert",
        "request_day": DateTime.now().toString().substring(0, 10),
        "request_date": date.text,
        "request_status": "0",
        "payment_method": listOfDropBoxValue[0],
        "request_price":
            "${price * int.parse(count.text)}",
        "request_quantity": count.text,
        "coustomer_name": customerName,
        "coustomer_phone": customerPhone,
        "product_id": "$id"
      };
      log("DATA....$data");
      await remoteState.api.request(AppLinks.reserve, {
        "op_type": "insert",
        "request_day": DateTime.now().toString().substring(0, 10),
        "request_date": date.text,
        "request_status": "0",
        "payment_method": listOfDropBoxValue[0],
        "request_price":
            "${price * int.parse(count.text)}",
        "request_quantity": count.text,
        "coustomer_name": customerName,
        "coustomer_phone": customerPhone,
        "product_id": "$id"
      },label: "عملية الحجز");
      date.text="";
      count.text="";
    }
  }

  TextEditingController listOfController(int index) {
    final controller = [ count, date];
    return controller[index];
  }

  int value = 0;
  void price(int val, {bool? isFromDrop = false}) {
    if (isFromDrop == true) {
      value = int.tryParse(count.text)! * remoteState.servicesState[0].price!;
      update();
    } else {
      value = val;
      update();
    }
  }

  void checkFromUser() async {
    if (storage!.read("customerName") != null) {
      customerName = storage!.read("customerName");
      customerPhone = storage!.read("customerPhone");
      update();
      log("$customerName");
    }
      log("$customerName");
  }
}
