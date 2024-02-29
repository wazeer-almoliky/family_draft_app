import 'package:family/binding/initial_data_binding.dart';
import 'package:family/binding/request_binding.dart';
import 'package:family/binding/service_binding.dart';
import 'package:family/binding/user_binding.dart';
import 'package:family/utilities/services/app_services.dart';
import 'package:family/view/screens/add_service.dart';
import 'package:family/view/screens/initia_data_screen.dart';
import 'package:family/view/screens/request_screen.dart';
import 'package:family/view/screens/services_screen.dart';
import 'package:family/view/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool isVisible = true.obs;
  ScrollController scrollController = ScrollController();
  final storage = AppService.getStorage;
  var admin = "";
  int? userID;
  @override
  void onInit() {
    super.onInit();
    checkFromUser();
  }

  void checkFromUser() async {
    if (storage!.read("userType") != null) {
      admin = storage!.read("userType");
      userID = storage!.read("userID");
      update();
    }
  }

  void pages(int index, {bool? isFromAdmin = false}) {
      if (index == 0) {
        if(admin =="ادمن"){
          go(const ServicesScreen(),
            transition: Transition.leftToRightWithFade,
            binding: ServiceBinding(),
            arguments: {"productID":0,"photoID":0});
        }else{
          go(const InitialDataScreen(),
            transition: Transition.zoom, binding: InitialData());
        }
      }
      if (index == 1) {
        if(admin =="ادمن"){
          go(const AddService(),
            transition: Transition.upToDown, binding: ServiceBinding(),arguments: {"productID":0,"photoID":0});
        }else{
          go(const ServicesScreen(),
            transition: Transition.leftToRightWithFade,
            binding: ServiceBinding(),
            arguments: {"productID":0,"photoID":0});
        }
      }
      if (index == 2) {
        if(admin =="ادمن"){
          go(const UserScreen(),
            transition: Transition.rightToLeft, binding: UserBinding());
        }else{
          go(const AddService(),
            transition: Transition.upToDown, binding: ServiceBinding(),arguments: {"productID":0,"photoID":0});
        }
      }
      if (index == 3) {
        go(const RequestScreen(),
            transition: Transition.rightToLeftWithFade,
            binding: RequestBinding(),
            arguments: {"userState": 0});
      }
      if (index == 4) {
        go(const RequestScreen(),
            transition: Transition.leftToRightWithFade,
            binding: RequestBinding(),
            arguments: {"userState": 1});
      }
     
  }

  void go(dynamic page,
      {Transition? transition, Bindings? binding, dynamic arguments}) async {
    await Get.to(page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      transition: transition,
      binding: binding,
      arguments: arguments,
    );
  }

  add()async{
    await Get.to(()=>const AddService(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      transition: Transition.circularReveal,
      binding: ServiceBinding(),
      
    );
  }
}
