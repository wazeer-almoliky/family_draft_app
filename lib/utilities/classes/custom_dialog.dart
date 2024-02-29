import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/controller/request_controller.dart';
import 'package:family/controller/services_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';

class CustomAlertDialog {
  // static final controller = Get.find();
  static callSnakBar(String title, String message,
      {Color? backgroundColor, Color? colorText}) {
    Get.snackbar(
      title,
      message,
      titleText: Container(),
      messageText: CustomText(
        width: Get.width,
        fontFamily: ArabicFont.dubai,
        alignment: Alignment.center,
        text: message,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        colorText: colorText ?? AppColors.whiteColor,
      ),
      colorText: colorText,
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 15),
      maxWidth: Get.width,
      icon: Icon(
        colorText != null ? Icons.info_outline : Icons.error,
        color: AppColors.whiteColor,
        size: 28,
      ),
      backgroundColor: backgroundColor ?? AppColors.primary,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 3500),
      animationDuration: const Duration(milliseconds: 800),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 5,
    );
  }

  static void showSnackBar(String text, {double? size,Color? color}) {
    Get.rawSnackbar(
      // borderRadius: 20.0,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 1),
      messageText: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        decoration: BoxDecoration(
            color: color?? AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
            ),
        child: Text(
          text,
          style: ArabicTextStyle(
              arabicFont: ArabicFont.tajawal,
              color: color??AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.transparent,
      // maxWidth: Get.context!.responsive<double>(400),
    );
  }

  static void show({int? id, String? title}) {
    final outerterController = Get.find<ServicesController>();
    Get.generalDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                scrollable: true,
                actionsAlignment: MainAxisAlignment.center,
                // titlePadding:const EdgeInsets.only(top: 20),
                contentPadding: const EdgeInsets.only(
                    top: 0.0, bottom: 80, right: 30, left: 30),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                title: CustomText(
                  text: title!,
                  fontSize: 25,
                  alignment: Alignment.topCenter,
                  isHaveBorder: true,
                  fontWeight: FontWeight.bold,
                ),
                content: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, top: 3),
                  child: SizedBox(
                    width: Get.width - 110,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GetBuilder<ServicesController>(
                          init: ServicesController(),
                          builder: (outerterController) {
                            return Form(
                                key: outerterController.servicesKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  // shrinkWrap: true,
                                  // physics: const BouncingScrollPhysics(),
                                  children: [
                                    ...List.generate(
                                        InputFieldData.serviceScreen.length,
                                        (index) => InputField(
                                              controller: outerterController
                                                  .listOfController(index),
                                              label: InputFieldData
                                                  .serviceScreen[index].label,
                                              hint: InputFieldData
                                                  .serviceScreen[index].label,
                                              suffixIcon: Icon(InputFieldData
                                                  .serviceScreen[index].icon),
                                              isNumber: false,
                                              onValid: (val) {
                                                return FormValidations
                                                    .checkValidations(
                                                        val!,
                                                        InputFieldData
                                                            .serviceScreen[
                                                                index]
                                                            .min!,
                                                        InputFieldData
                                                            .serviceScreen[
                                                                index]
                                                            .max!);
                                              },
                                            ))
                                  ],
                                ));
                          }),
                    ),
                  ),
                ),
                actions: List.generate(
                    2,
                    (index) => CustomButton(
                          onPressed: () {
                            if (index == 0) {
                              Get.back();
                              outerterController.updateData(id: id);
                            } else {
                              Get.back();
                            }
                          },
                          text: index == 0 ? "حفـــظ" : "إلغــاء",
                          fontFamily: ArabicFont.changa,
                          buttonColor: AppColors.primary,
                          textColor: AppColors.secondary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 0),
                        )),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (_, a1, a2) {
          return Container();
        });
  }

  static void demoDetail(String name, int state, int userID,
      {int? count, String? date, bool? isNotAdmin = false}) async {
    final outerController = Get.find<ResquestController>();
    await Get.generalDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOut.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                scrollable: true,
                actionsAlignment: MainAxisAlignment.center,
                insetPadding: const EdgeInsets.symmetric(horizontal: 12),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                title: const CustomText(
                  text: "التفاصيــل",
                  alignment: Alignment.center,
                ),
                content: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom, top: 3),
                  child: SizedBox(
                    width: Get.width - 110,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "الاســم :",
                              fontSize: 18,
                            ),
                            CustomText(
                              text: name,
                              fontSize: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "الحــالة :",
                              fontSize: 18,
                            ),
                            CustomText(
                              text: state == 0 ? "غير مفعل" : "مفعل",
                              fontSize: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (isNotAdmin == true)
                          Column(
                            children: [
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: "عدد الحجوزات :",
                                    fontSize: 18,
                                  ),
                                  CustomText(
                                    text: "$count",
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: "التـأريخ",
                                    fontSize: 18,
                                  ),
                                  // const SizedBox(
                                  //   width: 30,
                                  // ),
                                  CustomText(
                                    text: date!,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ],
                          )
                      ],
                    )),
                  ),
                ),
                actions: [
                  ...List.generate(
                      2,
                      (index) => CustomButton(
                            onPressed: () {
                              if (index == 0) {
                                Get.back();
                                if (isNotAdmin == true) {
                                  // log("ID::: $userID");
                                  outerController.updateData(userID);
                                } else {
                                  outerController.updateUser(userID,disableUser: 1,hint: "القبـول");
                                }
                              }
                              if (index == 1) {
                                Get.back();
                              }
                            },
                            buttonColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            text: index == 0 ? "قبــول" : "إلغـاء",
                            fontSize: 18,
                            textColor: AppColors.whiteColor,
                          ))
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
        barrierDismissible: true,
        barrierLabel: '',
        // context: Get.context!,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
