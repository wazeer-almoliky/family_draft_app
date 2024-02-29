import 'dart:io';
import 'package:flutter/material.dart';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/status_request.dart';

class AppFunctions {
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      // CustomAlertDialog.callSnakBar("", "لا يوحد انترنت!");
      return false;
    }
  }

  static handlingData(response) {
    if (response is StatusRequest) {
      return response;
    } else {
      return StatusRequest.success;
    }
  }

  static Size getWdigetSize(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    return box.size;
  }

  static Future<void> msgStatus(response, resp, bool isRead,
      {String? error, String? label}) async {
    if (isRead == true) {
      if (response == StatusRequest.success) {
        if (resp["status"] == "success") {
          CustomAlertDialog.callSnakBar("", "تمت $label بنجاح",
              colorText: AppColors.whiteColor, backgroundColor: Colors.green);
        }
      }
      
    } else if (response == StatusRequest.lateException) {
      await CustomAlertDialog.callSnakBar("", "أخذ وقتا أطول للإتصال",
          colorText: AppColors.whiteColor, backgroundColor: Colors.red);
    } else if (response == StatusRequest.offlinefailure) {
      await CustomAlertDialog.callSnakBar("", "لا يوحد انترنت!",
          colorText: AppColors.whiteColor, backgroundColor: Colors.red);
    } else if (response == StatusRequest.serverfailure) {
      await CustomAlertDialog.callSnakBar("", "خطأ في الإتصال بالسيرفر!",
          colorText: AppColors.whiteColor, backgroundColor: Colors.red);
    } else if (response == StatusRequest.serverException) {
      await CustomAlertDialog.callSnakBar("", "لا يوجد صفحة بهذا الاسم",
          colorText: AppColors.whiteColor, backgroundColor: Colors.red);
    } else {}
  }
}