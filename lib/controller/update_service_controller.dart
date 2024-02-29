import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:family/app_links.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/services/app_services.dart';

class UpdateServiceController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final name = TextEditingController();
  final note = TextEditingController();
  final price = TextEditingController();
  final serviceKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> mediaFileList = [];
  var valueOfDropBox = "";
  var admin = "";
  String? label,serviceName;
  int? prID, userID2,userID,photoID,prdPrice,familyID,catID;
  @override
  void onInit() {
    checkFromUser();
    super.onInit();
    label = Get.arguments["label"]??"";
    prID = Get.arguments["prID"]??0;
    prdPrice = Get.arguments["price"]??0;
    serviceName = Get.arguments["serviceName"]??"";
    photoID = Get.arguments["photoID"]??0;
    catID = Get.arguments["catID"]??0;
    name.text=serviceName!;
    price.text="${prdPrice??0}";
  }

  TextEditingController listOfController(int index) {
    final controller = [name, price,note];
    return controller[index];
  }

  void updateRequest() async {
    if (admin == "ادمن") {
      final data = {
        "op_type": "update",
        "category_name": name.text,
        "category_note": note.text,
        "category_id": "$prID",
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api
            .request(AppLinks.service, data, label: "عملية التعديل");
            return;
      }
      await remoteState.api.requestCapture(
          AppLinks.service, data, File(mediaFileList[0].path),
          label: "عملية التعديل",isAlone: true);
    } else {
      final data = {
        "op_type": "update",
        "product_name": name.text,
        "product_price": price.text,
        "product_description": note.text,
        "product_id": "$prID",
        "family_id": "$familyID",
        "category_id": "$catID",
      };
      final data2 = {
        "op_type": "update",
        "product_id": "$prID",
        "photo_id": "$photoID",
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api
            .request(AppLinks.product, data, label: "عملية التعديل");
      } else {
        await remoteState.api.requestCapture(
            AppLinks.photo, data2, File(mediaFileList[0].path),
            label: "عملية التعديل",isAlone: true);
      }
    }
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      familyID = storage!.read("familyID");
      update();
    }
  }

  Future<void> getImage(ImageSource source) async {
    remoteState.isLoading(true);
    try {
      final pickedFile = await _picker.pickMultiImage();
      List<XFile> xfilePick = pickedFile;
      if (xfilePick.isNotEmpty) {
        for (var i = 0; i < xfilePick.length; i++) {
          mediaFileList.add(xfilePick[i]); //File(xfilePick[i].path)
        }
        update();
      } else {
        log('No image selected.');
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void addImage() async {
    if (mediaFileList.isEmpty) {
    } else {
      await remoteState.api.requestCapture(
          AppLinks.photo,
          {"op_type": "insert", "product_id": "$prID"},
          File(mediaFileList[0].path),
          label: "عملية الاضافة",isAlone: true);
    }
  }

  Future<void> getImageCamera() async {
    remoteState.isLoading(true);
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        mediaFileList.add(pickedFile);
        update();
      }
    } finally {
      remoteState.isLoading(false);
    }
  }
}
