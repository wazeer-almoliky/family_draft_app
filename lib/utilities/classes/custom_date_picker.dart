import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePicker {
  static Future<DateTime> showDate()async{
    final DateTime? dt =await showDatePicker(context: Get.context!,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate:DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 360*10)),
                        locale:const Locale('ar'),
                        confirmText: "تأكيد",
                        cancelText: "إلغـاء",
                        helpText: "اختـار تأريخ",
                        fieldHintText: "التأريخ",
                        fieldLabelText: "التأريخ",
                        keyboardType: TextInputType.datetime,
                        textDirection: TextDirection.rtl,
                        );
    // ignore: prefer_if_null_operators
    final d = dt !=null? dt : DateTime.now();
    return d;
  }
}