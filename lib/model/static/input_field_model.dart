import 'package:flutter/material.dart';

class InputFieldModel {
  final String? label,hint;
  final int? min,max;
  final IconData? icon;
 const InputFieldModel({this.label, this.hint, this.min, this.max, this.icon});
}
class InputFieldData {
  static const signUp = [
    InputFieldModel(label: "اســم المستخــدم",min: 4,max: 30,icon: Icons.person_outlined),
    InputFieldModel(label:"كلمــة المرور",min: 4,max: 12,icon: Icons.password),
    InputFieldModel(label: "رقــم الهاتــف",min: 9,max: 12,icon: Icons.phone),
  ];
  static const userAdmin = [
    InputFieldModel(label: "اســم المستخــدم",min: 4,max: 30,icon: Icons.info_outline),
    InputFieldModel(label:"كلمــة المرور",min: 4,max: 12,icon: Icons.password),
  ];

  static const initScreen = [
    InputFieldModel(label: "اســم الأســرة",min: 2,max: 30,icon: Icons.info_outline),
    InputFieldModel(label:"عنـوان الأســرة",min: 2,max: 30,icon: Icons.place),
    InputFieldModel(label: "رقــم الهاتــف",min: 9,max: 12,icon: Icons.phone),
  ];
  static const serviceScreen = [
    InputFieldModel(label: "اســم الصنــف",min: 2,max: 30,icon: Icons.design_services),
    InputFieldModel(label:"ملاحظــات",min: 0,max: 50,icon: Icons.note),
  ];
  static const serviceScreen2 = [
    InputFieldModel(label: "اســم الصنــف",min: 2,max: 30,icon: Icons.design_services),
    InputFieldModel(label: "السعــر",min: 2,max: 30,icon: Icons.money),
    InputFieldModel(label:"ملاحظــات",min: 0,max: 50,icon: Icons.note),
  ];

  static const customerPeriod = [
    InputFieldModel(label:"الكميــة",min: 1,max: 2,icon: Icons.numbers),
    InputFieldModel(label:"التـــأريــخ",min: 10,max: 10,icon: Icons.date_range),
  ];
}