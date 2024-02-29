import 'package:family/controller/stting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppColors {
 static final outerController = Get.put(SettingController());
  static Color  primary = Color(outerController.mainColor);
  static const primary101 =  Color(0xffD97FCD);
  static Color secondary = Color(outerController.mainColor2);
  static const blackColor = Color(0xff261824);
  static const whiteColor = Color(0xffffffff);
  static const transparentColor = Colors.transparent;
  static const grayColor = Color(0xffF0F0F0);
  static const red = Color.fromARGB(255, 238, 5, 5);
}
