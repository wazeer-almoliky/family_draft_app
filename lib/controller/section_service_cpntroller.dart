import 'package:family/app_links.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/family_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SectionServiceController extends GetxController {
  final remoteState = RemoteState();
  final storage = AppService.getStorage;
  final search = TextEditingController();
  RxList<Family> allFamily = <Family>[].obs;
  int? id;
  String? name;
  @override
  void onInit() {
    super.onInit();
    allFamily.value=remoteState.givserState;
    id = Get.arguments["id"];
    name = Get.arguments["name"];
    fetchData();
  }

  void fetchData() async {
    remoteState.givserState.clear();
    // remoteState.isLoading(true);
    try {
      final response = await remoteState.api.respone(
          "${AppLinks.givenService}?op_type=selectwhere&category_id=$id");
      if (response != null) {
        remoteState.givserState
            .addAll(response.map((e) => Family.fromjson(e)).toList());
        remoteState.givserState.refresh();
      }
    } finally {
      // remoteState.isLoading(false);
    }
  }

  void detailsViewScreen({int? id, String? name}) async {
    Get.to(() => const FamilyProduct(),
        // binding: DetailsViewBinding2(),
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        transition: Transition.circularReveal,
        arguments: {"id": id, "name": name});
  }

  void filterCategory(String name) {
    List<Family> result = [];
    if (name.isEmpty) {
      result = allFamily;
    } else {
      result =
          allFamily.where((element) => element.name!.contains(name)).toList();
    }
    allFamily.value = result;
  }
}
