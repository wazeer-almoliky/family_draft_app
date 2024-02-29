import 'dart:developer';
import 'dart:io';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:family/app_links.dart';
import 'package:family/binding/details_view_binding.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/functions/status_request.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/details_view.dart';

class ServicesController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final name = TextEditingController();
  final price = TextEditingController();
  final note = TextEditingController();
  final servicesKey = GlobalKey<FormState>();
  var isUpdate = -1;
  // final periodKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<XFile> mediaFileList = [];
  var valueOfDropBox = ["", ""];
  var admin = "";
  int? userID, photoID, productID1, familyID;
  @override
  void onInit() {
    super.onInit();
    remoteState.serviceState.clear();
    remoteState.servicesState.clear();
    remoteState.givserState.clear();
    checkFromUser();
    productID1 = Get.arguments["productID"];
    photoID = Get.arguments["photoID"];
    fetchData();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      familyID = storage!.read("familyID");
      update();
    }
    log("FamilyID.. $familyID");
  }

  void fetchData() async {
   
   // remoteState.isLoading(true);
    try {
      final response = await Future.wait([
        remoteState.api
            .respone("${AppLinks.product}?op_type=select&family_id=$familyID"),
        remoteState.api.respone("${AppLinks.service}?op_type=select"),
        remoteState.api.respone(
            "${AppLinks.givenService}?op_type=select2&user_id=$userID"),
      ]);

      if (response[1] != null) {
        remoteState.serviceState
            .addAll(response[1]!.map((e) => Catagory.fromjson(e)).toList());
        remoteState.serviceState.refresh();
      }
      if (response[0] != null) {
        remoteState.servicesState
            .addAll(response[0]!.map((e) => Product.fromjson(e)).toList());
        remoteState.servicesState.refresh();
        log(">>${remoteState.servicesState}<<");
      }
      if (response[2] != null) {
        remoteState.givserState
            .addAll(response[2]!.map((e) => Family.fromjson(e)).toList());
        remoteState.givserState.refresh();
        // log()
      }
    } finally {
      remoteState.isLoading(false);
    }
  }

  void request() async {
    StatusRequest.loading;
    // log("Admin is $admin ");
    if (servicesKey.currentState!.validate()) {
      if (admin == "ادمن") {
        if(mediaFileList.isEmpty){
           CustomAlertDialog.showSnackBar("لا توجــد  صـورة");
          return;
        }
        await remoteState.api.requestCapture(
            AppLinks.service,
            {
              "op_type": "insert",
              "category_name": name.text,
              "category_note": note.text,
            },
            File(mediaFileList[0].path),label: "عملية الاضافة",isAlone: true);
      } else {
        if(valueOfDropBox[1]==""){
          CustomAlertDialog.showSnackBar("لا توجــد بيانــات الأسرة");
          return;
        }
        int? productID;
        final data = {
          "op_type": "insert",
          "product_name": name.text,
          "product_price": price.text,
          "product_description": note.text,
          "family_id": remoteState
              .getID(remoteState.givserState, valueOfDropBox[1])
              .toString(),
          "category_id": remoteState
              .getID(remoteState.serviceState, valueOfDropBox[0])
              .toString(),
        };
        if (mediaFileList.isEmpty) {
         await remoteState.api.request(AppLinks.product, data,label: "عملية الاضافة");
         return;
        } else {
          final id = await remoteState.api.request(AppLinks.product, data,label: "عملية الاضافة");
          log("----------$id ");
          productID = id![0];
          await remoteState.api.requestCapture(
              AppLinks.photo,
              {"op_type": "insert", "product_id": "$productID"},
              File(mediaFileList[0].path),label: "عملية الاضافة",isAlone: false);
        }
      }
    }
    // update();
    clear();
  }
  void addImage()async{
    if(mediaFileList.isEmpty){

    }else{
      await remoteState.api.requestCapture(
              AppLinks.photo,
              {"op_type": "update", "product_id": "$productID1"},
              File(mediaFileList[0].path),label: "عملية الاضافة",isAlone: true);
    }
  }

  void updateRequest() async {
    if (admin == "ادمن") {
      final data = {
        "op_type": "update",
        "category_name": name.text,
        "category_note": note.text,
        "category_id": productID1,
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api.request(AppLinks.service, data,label: "عملية التعديل");
      }
      await remoteState.api
          .requestCapture(AppLinks.service, data, File(mediaFileList[0].path),label: "عملية التعديل",isAlone: true);
    } else {
      final data = {
        "op_type": "update",
        "product_name": name.text,
        "product_price": price.text,
        "product_description": note.text,
        "product_id": productID1,
        "family_id": remoteState
            .getID(remoteState.givserState, valueOfDropBox[1])
            .toString(),
        "category_id": remoteState
            .getID(remoteState.serviceState, valueOfDropBox[0])
            .toString(),
      };
      if (mediaFileList.isEmpty) {
        await remoteState.api.request(AppLinks.product, data,label: "عملية التعديل");
      } else {
        await remoteState.api.requestCapture(
            AppLinks.product, data, File(mediaFileList[0].path),label: "عملية التعديل",isAlone: true);
      }
    }
  }

  void clear() {
    name.text = "";
    note.text = "";
    mediaFileList = [];
    update();
  }

  TextEditingController listOfController(int index) {
    final controller = admin == "ادمن" ? [name, note] : [name, price, note];
    return controller[index];
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

  void valueOfDropDownBox(String val) {
    valueOfDropBox[0] = val;
    update();
  }

  List<String> listOfDataService(int index) {
    final data = [
      remoteState.getNames(remoteState.serviceState),
      remoteState.getNames(remoteState.givserState)
    ];
    return data[index];
  }

  void detailsViewScreen({int? id, String? name,int? price,int? catagoryID}) async {
    Get.to(() => const DetailsView(),
        binding: DetailsViewBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: Transition.circularReveal,
        arguments: {"id": id, "name": name,"price":price,"catID":catagoryID});
  }

  void updateData({int? id}) async {
    if (servicesKey.currentState!.validate()) {
      await remoteState.api.request(AppLinks.service, {
        "op_type": "update",
        "category_name": name.text,
        "category_note": note.text,
        "category_id": "$id"
      },label: "عملية التعديل");
    }
  }
  void deleteData(int id) async {
      await remoteState.api.request(AppLinks.service, {
        "op_type": "delete",
        "category_id": "$id"
      },label: "عملية الحذف");
  }
}
