import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/details_view_controller2.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NormalUserWidget {
  static void normalUser(int id,String name) {
    final controller = Get.put(DetailsViewController2());
    Get.bottomSheet(
       Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
          height: Get.height - 150,
         child: Column(
          children: [
            const CustomText(
              text: "بيــانات العميــل",
              fontFamily: ArabicFont.arefRuqaa,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12,),
            const Divider(height: 2.5,),
            const SizedBox(height: 12,),
             Form(
              key: controller.userKey,
              child: Column(
              children: List.generate(2, (index){
                return InputField(
                  controller: controller.listOfController(index),
                  label: index==0?"الاســـــــم":"رقــم الهــاتف",
                  suffixIcon: Icon(index==0?Icons.person_3:Icons.phone),
                  isNumber: index==1,
                  onValid: (val){
                    return FormValidations.checkValidations(val!, index==0?3:9, index==0?50:12);
                  },
                );
              }),
            )),
            const SizedBox(height: 12,),
            CustomButton(onPressed: (){
              controller.checkFromUser( id, name);
            },text: "حفـــــظ",fontSize: 20,
            textColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 13),
            )
          ],
             ),
       ),

      isScrollControlled: true,
        elevation: 1.5,
        useRootNavigator: true,
        enterBottomSheetDuration: const Duration(milliseconds: 450),
        exitBottomSheetDuration: const Duration(milliseconds: 450),
        backgroundColor: AppColors.grayColor
    );
  }
}
