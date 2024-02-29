import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/initial_data_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_drop_down_search.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialDataScreen extends GetView<InitialDataControllrt> {
  const InitialDataScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.put<InitialDataControllrt>(InitialDataControllrt());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DAppBar(
        title: "البيانــات الأسـاسيـة",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 40),
          child: Form(
              key: controller.initialDataKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(() {
                    if (outerController.remoteState.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CustomDropDownSearch(
                        items: outerController.listOfDataService(),
                        // labelText: "نــوع الخدمـة",
                        hintText: "نــوع الخدمة",
                        margin: const EdgeInsets.only(bottom: 25),
                        onChanged: (val) {
                          if (val != null) {
                            outerController.serviceID = val;
                            log("$val");
                            outerController.update();
                          }
                        },
                      );
                    }
                  }),
                  ...List.generate(
                    InputFieldData.initScreen.length,
                    (index) => InputField(
                        controller: controller.listOfController(index),
                        label: InputFieldData.initScreen[index].label,
                        hint: InputFieldData.initScreen[index].label,
                        suffixIcon: Icon(InputFieldData.initScreen[index].icon),
                        isReadOnly: false,
                        isNumber: index > 1,
                        onValid: (val) {
                          return FormValidations.checkValidations(
                              val!,
                              InputFieldData.initScreen[index].min!,
                              InputFieldData.initScreen[index].max!,
                              isValid: index > 1);
                        },
                        margin: const EdgeInsets.only(bottom: 35)),
                  ),
                  CustomButton(
                    onPressed: () {
                      controller.login();
                    },
                    text: "حفـــــظ",
                    fontFamily: ArabicFont.changa,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    buttonColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
