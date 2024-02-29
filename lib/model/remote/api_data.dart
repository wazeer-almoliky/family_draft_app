import 'dart:io';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/api_function.dart';
import 'package:family/utilities/functions/app_functions.dart';
import 'package:family/utilities/functions/status_request.dart';

class ApiData {
  final Crud curd;
  const ApiData(this.curd);
  Future<List<dynamic>?> request(String url, Map<String, dynamic> data,
      {String? label}) async {
    StatusRequest statusRequest = StatusRequest.loading;
    final respone = await curd.post(url, data);
    statusRequest = AppFunctions.handlingData(respone);
    return respone.fold((e) {
      AppFunctions.msgStatus(statusRequest, e, true);
      return null;
    }, (r) {
      if (r["status"] == "success") {
        List<dynamic> data;
        data = r.length == 1 ? [r["product_id"],r["family_id"]] : [r["product_id"],r["family_id"]];
        // List<dynamic> data = r["data"];
        AppFunctions.msgStatus(statusRequest, r, true, label: label);
        return data;
      } else {
        AppFunctions.msgStatus(statusRequest, r, true, label: label);
        return null;
      }
    });
  }

  Future<List<dynamic>?> requestCapture(
      String url, Map<String, dynamic> data, File file,
      {String? label,bool? isAlone=false}) async {
    StatusRequest statusRequest = StatusRequest.loading;
    final respone = await curd.capturePost(url, data, file);
    statusRequest = AppFunctions.handlingData(respone);
    return respone.fold((e) {
      AppFunctions.msgStatus(statusRequest, e, true);
      return null;
    }, (r) {
      if (r["status"] == "success" && isAlone==true) {
        // List<dynamic> data;
        // data = r.isEmpty ? [] : [];
        AppFunctions.msgStatus(statusRequest, r, true,label:label);
        return [];
      }

      return null;
    });
  }

  Future<List<dynamic>?> respone(String url,{bool? isSignUp=false}) async {
    final respone = await curd.get(url);
    return respone.fold((e) {
      AppFunctions.msgStatus(e, respone, false);
      return null;
    }, (r) {
      if (r["status"] == "success") {
        List<dynamic> data = r["data"];
        return data;
      } else if (r["status"] == "failed" && isSignUp==true) {
        CustomAlertDialog.callSnakBar(
            "", "تـأكد من اســم المستخــدم أو كلمـة المرور",
            colorText: AppColors.whiteColor, backgroundColor: AppColors.red);
       return null;
      } else {
        // AppFunctions.msgStatus(r, respone, true);
        return null;
      }
    });
  }

  Future<Map<String, dynamic>?> fetchMapData(String url) async {
    final respone = await curd.get(url);
    return respone.fold((e) {
      AppFunctions.msgStatus(e, respone, false);
      return null;
    }, (r) {
      if (r["status"] == "success") {
        Map<String, dynamic> data = r["data"];
        return data;
      }
      return null;
    });
  }
}
