import 'package:family/app_links.dart';
import 'package:family/binding/section_service_binding.dart';
import 'package:family/model/remote/api_model.dart';
import 'package:family/model/remote/remote_state.dart';
import 'package:family/view/screens/section_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final remoteState = RemoteState();
  final search = TextEditingController();
  RxList<Catagory> allCategory = <Catagory>[].obs;
  @override
  void onInit() {
    remoteState.serviceState.clear();
    fetchData();
    super.onInit();
    allCategory.value = remoteState.serviceState;
  }

  void fetchData() async {
    // remoteState.serviceState.clear();

    // remoteState.serviceState.clear();
    remoteState.isLoading(true);
    try {
      final response = await remoteState.api
          .respone("${AppLinks.service}?op_type=select");
      if (response != null) {
        remoteState.serviceState
            .addAll(response.map((e) => Catagory.fromjson(e)).toList());
        remoteState.serviceState.refresh();
      }
      //log("${remoteState.serviceState[0].name}");
    } finally {
      remoteState.isLoading(false);
    }
  }

  void sectionServiceViewScreen({int? id, String? name, int? index}) async {
    final tr = [
      Transition.zoom,
      Transition.upToDown,
      Transition.downToUp,
      Transition.leftToRight,
      Transition.rightToLeft,
      Transition.rightToLeftWithFade,
      Transition.leftToRightWithFade,
      Transition.size,
      Transition.circularReveal
    ];
    Get.to(() => const SectionService(),
        binding: SectionServiceBinding(),
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
        transition: tr[index!],
        arguments: {"id": id, "name": name});
  }

  @override
  void onClose() {
    super.onClose();
    remoteState.isLoading(false);
  }

  void filterCategory(String name) {
    List<Catagory> result = [];
    if (name.isEmpty) {
      result = allCategory;
    } else {
      result =
          allCategory.where((element) => element.name!.contains(name)).toList();
    }
    allCategory.value = result;
  }


}
