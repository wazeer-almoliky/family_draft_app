import 'dart:io';

import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/services_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_drop_down_search.dart';
import 'package:family/utilities/classes/custom_icon_button.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatelessWidget {
  const AddService({super.key});
  @override
  Widget build(BuildContext context) {
    final outerterController = Get.put<ServicesController>(ServicesController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: "إضــافة خدمـــة",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.only(top: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          children: [
            Form(
                key: outerterController.servicesKey,
                child: Column(
                  children: [
                    if (outerterController.admin == "عادي")
                      ...List.generate(
                          2,
                          (index) => Obx(() {
                                if (outerterController
                                    .remoteState.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return CustomDropDownSearch(
                                    items: outerterController
                                        .listOfDataService(index),
                                    // labelText: "نــوع الخدمـة",
                                    hintText:
                                        index == 0 ? "الصنــف" : "الأســرة",
                                    margin: const EdgeInsets.only(bottom: 15),
                                    onChanged: (val) {
                                      if (val != null) {
                                        outerterController
                                            .valueOfDropBox[index] = val;
                                        outerterController.update();
                                      }
                                    },
                                  );
                                }
                              })),
                    ...List.generate(
                        outerterController.admin == "عادي"
                            ? InputFieldData.serviceScreen2.length
                            : InputFieldData.serviceScreen.length,
                        (index) => InputField(
                              controller:
                                  outerterController.listOfController(index),
                              label: outerterController.admin == "عادي"
                                  ? InputFieldData.serviceScreen2[index].label
                                  : InputFieldData.serviceScreen[index].label,
                              hint: outerterController.admin == "عادي"
                                  ? InputFieldData.serviceScreen2[index].label
                                  : InputFieldData.serviceScreen[index].label,
                              // suffixIcon: Icon(
                              //     InputFieldData.serviceScreen[index].icon),
                              isNumber: outerterController.admin == "عادي" &&
                                  index == 1,
                              onValid: (val) {
                                return FormValidations.checkValidations(
                                    val!,
                                    outerterController.admin == "عادي"?InputFieldData.serviceScreen2[index].min!:InputFieldData.serviceScreen[index].min!,
                                    outerterController.admin == "عادي"?InputFieldData.serviceScreen2[index].max!:InputFieldData.serviceScreen[index].max!);
                              },
                            ))
                  ],
                )),
            const SizedBox(
              height: 18,
            ),
            // if (outerterController.admin == "عادي")
              CustomText(
                text: "صــور",
                fontFamily: ArabicFont.tajawal,
                fontSize: 22,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold,
                colorText: AppColors.primary,
              ),
            const SizedBox(
              height: 13,
            ),
            // if (outerterController.admin == "عادي")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    2,
                    (index) => CustomIconButton(
                          onPressed: () async {
                            if (index == 0) {
                              await outerterController.getImageCamera();
                            } else {
                              await outerterController
                                  .getImage(ImageSource.gallery);
                            }
                          },
                          icon: index == 0 ? Icons.camera_alt : Icons.image,
                          color: AppColors.secondary,
                          size: 70,
                        )),
              ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
              onPressed: () async {
                if(outerterController.productID1==0){
                  if(outerterController.photoID==0){
                    outerterController.request();
                  }else{
                   outerterController.addImage();
                  }
                  
                }else{
                 outerterController.updateRequest();
                }
                
              },
              text:outerterController.productID1==0? "إضـافــــة":"نعـديـــل",
              fontFamily: ArabicFont.dinNextLTArabic,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondary,
              buttonColor: AppColors.primary,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
            ),
            const SizedBox(
              height: 13,
            ),
           // if (outerterController.admin == "عادي")
              GetBuilder<ServicesController>(
                  init: ServicesController(),
                  builder: (innerController) {
                    return GridView.count(
                      crossAxisCount: 1,
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
