import 'dart:developer';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/reserve_screen.dart';
import 'package:family/view/widgets/customer_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/app_links.dart';
import 'package:family/binding/reserv_binding.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';

class DetailsViewController2 extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final userName = TextEditingController();
  final phone = TextEditingController();
  final userKey = GlobalKey<FormState>();
  int? id,price;
  String? name;
  @override
  void onInit() {
    super.onInit();
    remoteState.photoState.clear();
    id = Get.arguments["id"];
    name = Get.arguments["name"];
    price = Get.arguments["price"];
    fetchData();
    //  Get.find<ReserveController>();
  }

  void fetchData() async {
    // remoteState.serviceState.clear();
    // remoteState.servicesState.clear();
    // remoteState.photoState.clear();
    log(id.toString());
    try {
    var  response=await remoteState.api.respone("${AppLinks.photo}?op_type=select&product_id=$id");
      if(response !=null){
      remoteState.photoState
          .addAll(response.map((e) => Photo.fromjson(e)).toList());
      remoteState.photoState.refresh();
      }
    } finally {
      //remoteState.isLoading(false);
    }
  }

  void detailsViewScreen({int? id, String? name}) async {
    Get.to(() => const ReserveScreen(),
        binding: ReserveBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.downToUp,
        arguments: {"id": id, "name": name});
  }

  TextEditingController listOfController(int index) {
    final controller = [userName, phone];
    return controller[index];
  }

  void checkFromUser(int id, String name) {
    if (userKey.currentState!.validate()) {
      storage!.write("customerName", userName.text);
      storage!.write("customerPhone", phone.text);
      CustomAlertDialog.showSnackBar("تمـــت الإضـــافة بنجـــاح", size: 20);
      CustomerButtomSheet.customerSheet(id,price!,title: name);
    }
  }
}
