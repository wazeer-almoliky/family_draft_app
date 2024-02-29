import 'dart:developer';

import 'package:family/app_links.dart';
import 'package:family/binding/details_view_binding2.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/view/screens/details_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final remoteState = RemoteState();
  int? id;
  String? name;
  @override
  void onInit() {
    id = Get.arguments["id"];
    name = Get.arguments["name"];
    super.onInit();
    fetchData();
  }
  void fetchData()async{
    remoteState.servicesState.clear();
    try {
       final data =await remoteState.api.respone("${AppLinks.product}?op_type=select&family_id=$id");
       if(data !=null){
        remoteState.servicesState
          .addAll(data.map((e) => Product.fromjson(e)).toList());
      remoteState.servicesState.refresh();
      log(">>>>${remoteState.servicesState.length}<<<<");
       }
       
    } finally {
    }
  }

  void detailsViewScreen({int? id, String? name,int? price}) async {
    Get.to(() => const DetailsView2(),
        binding: DetailsViewBinding2(),
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        transition: Transition.leftToRightWithFade,
        arguments: {"id": id, "name": name,"price":price});
  }
}
