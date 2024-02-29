import 'dart:developer';
import 'dart:io';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:family/controller/update_service_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_icon_button.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/widgets/app_bar.dart';

class UpdateServiceScreen extends StatelessWidget {
  const UpdateServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateServiceController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: controller.label,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: ListView(
          children: [
            Form(
                key: controller.serviceKey,
                child: Column(
                  children: List.generate(
                      controller.admin == "ادمن"
                          ? InputFieldData.serviceScreen.length
                          : InputFieldData.serviceScreen2.length, (index) {
                    return InputField(
                      controller: controller.listOfController(index),
                      label: controller.admin == "ادمن"
                          ? InputFieldData.serviceScreen[index].label
                          : InputFieldData.serviceScreen2[index].label,
                      hint: controller.admin == "ادمن"
                          ? InputFieldData.serviceScreen[index].label
                          : InputFieldData.serviceScreen2[index].label,
                      isNumber: index > 1,
                      isPassword: false,
                      onValid: (val) {
                        return FormValidations.checkValidations(
                            val!,
                            controller.admin == "ادمن"
                                ? InputFieldData.serviceScreen[index].min!
                                : InputFieldData.serviceScreen2[index].min!,
                            controller.admin == "ادمن"
                                ? InputFieldData.serviceScreen[index].max!
                                : InputFieldData.serviceScreen2[index].max!);
                      },
                    );
                  }),
                )),

            CustomText(
              text: "صـــور",
              fontFamily: ArabicFont.tajawal,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              colorText: AppColors.primary,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 80,
            ),
            const Divider(
              height: 3.3,
            ),
            //   if (outerterController.admin == "عادي")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  2,
                  (index) => CustomIconButton(
                        onPressed: () async {
                          if (index == 0) {
                            await controller.getImageCamera();
                          } else {
                            await controller.getImage(ImageSource.gallery);
                          }
                        },
                        icon: index == 0 ? Icons.camera_alt : Icons.image,
                        color: AppColors.secondary,
                        size: 70,
                      )),
            ),
            const SizedBox(
              height: 100,
            ),
            CustomButton(
              onPressed: () {
                log(controller.prID.toString());

                if (controller.admin == "ادمن") {
                  controller.updateRequest();
                } else {
                  if (controller.photoID == 1) {
                    controller.addImage();
                    log("add+1");
                  } else {
                    controller.updateRequest();
                    log("up");
                  }
                }
              },
              text: controller.label,
              textColor: AppColors.secondary,
              buttonColor: AppColors.primary,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              fontSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            const SizedBox(
              height: 25,
            ),
            GetBuilder<UpdateServiceController>(
                init: UpdateServiceController(),
                builder: (innerController) {
                  return GridView.count(
                    crossAxisCount: 2,
                    // mainAxisSpacing: 10,
                    // crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: innerController.mediaFileList.isNotEmpty
                        ? List.generate(innerController.mediaFileList.length,
                            (index) {
                            return Container(
                              // color: AppColors.grayColor,
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: (Get.width / 2) - 10,
                                height: (Get.width / 2) - 10,
                                padding: const EdgeInsets.all(8.0),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: AppColors.grayColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColors.grayColor,
                                        width: 1.9,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside)),
                                child: Image.file(
                                  File(
                                    innerController.mediaFileList[index].path,
                                  ),
                                  width: (Get.width / 2) - 20,
                                  height: (Get.width / 2) - 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          })
                        : [
                            Center(
                              child: CustomText(
                                text: "",
                                fontFamily: ArabicFont.avenirArabic,
                                alignment: Alignment.center,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                colorText: AppColors.primary,
                              ),
                            )
                          ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
