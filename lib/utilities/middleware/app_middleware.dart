import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/utilities/services/app_services.dart';
class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  final appServices = Get.find<AppService>();
  @override
  RouteSettings? redirect(String? route) {
    // if (myServices.sharedPreferences.getString("step") == "2") {
    //   return const RouteSettings(name: AppRoute.homepage);
    // }
    // if (myServices.sharedPreferences.getString("step") == "1") {
    //   return const RouteSettings(name: AppRoute.login);
    // }
    return null;
  }
}