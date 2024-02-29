import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:family/binding/service_binding.dart';
import 'package:family/controller/services_controller.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/screens/add_service.dart';
import 'package:family/view/screens/service_update_screen.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.put<ServicesController>(ServicesController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: "الخدمــات",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(top: 25),
        child: Obx(() {
          if (outerController.remoteState.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // final data = outerController.admin == "ادمن"
            //     ? outerController.remoteState.serviceState
            //     : outerController.remoteState.servicesState;
            // final data1= outerController.admin=="ادمن"?[]:outerController.remoteState.servicesState;
            return ListView.builder(
              itemCount: outerController.admin == "ادمن"
                  ? outerController.remoteState.serviceState.length
                  : outerController.remoteState.servicesState.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final service = outerController.remoteState.serviceState;
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.secondary),
                  child: Material(
                    color: AppColors.transparentColor,
                    child: InkWell(
                      splashColor: const Color.fromARGB(255, 189, 189, 189),
                      borderRadius: BorderRadius.circular(15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: outerController.admin == "ادمن"
                                      ? outerController
                                          .remoteState.serviceState[index].name!
                                      : outerController.remoteState
                                          .servicesState[index].name!,
                                  colorText: AppColors.primary,
                                  fontFamily: ArabicFont.avenirArabic,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            if (outerController.admin != "ادمن")
                              Center(
                                child: CustomButton(
                                  onPressed: () {
                                    outerController.detailsViewScreen(
                                        id: outerController.remoteState
                                            .servicesState[index].id!,
                                        name: outerController.remoteState
                                            .servicesState[index].name!,
                                        price:outerController.remoteState
                                            .servicesState[index].price , 
                                        catagoryID:outerController.remoteState
                                            .servicesState[index].catagoryID , 
                                            );
                                  },
                                  text: "تفاصيـــل أكثـر",
                                  radius: 10,
                                  buttonColor: AppColors.primary,
                                  textColor: AppColors.secondary,
                                  fontSize: 19,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                ),
                              ),
                            if (outerController.admin == "ادمن")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(2, (index2) {
                                  return CustomButton(
                                    onPressed: () {
                                      if (index2 == 0) {
                                        log("${service[index].id!}");
                                        Get.to(
                                          () => const UpdateServiceScreen(),
                                          arguments: {
                                            "prID": service[index].id!,
                                            "label": "تعديل ${service[index].name}",
                                            "serviceName": "${service[index].name}"
                                          },
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.ease,
                                          transition: Transition.circularReveal,
                                        );
                                        // outerController.update();
                                      } else {
                                        outerController.deleteData(
                                            outerController.remoteState
                                                .serviceState[index].id!);
                                      }
                                    },
                                    text: index2 == 0 ? "تعديــــل" : "حــذف",
                                    radius: 10,
                                    buttonColor: AppColors.primary,
                                    textColor: AppColors.secondary,
                                    fontSize: 19,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  );
                                }),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.transparentColor,
        splashColor: AppColors.transparentColor,
        elevation: 0.0,
        onPressed: () {
          Get.to(
            () => const AddService(),
            binding: ServiceBinding(),
            arguments: {"productID": 0, "photoID": 0},
            duration: const Duration(milliseconds: 600),
            curve: Curves.ease,
            transition: Transition.circularReveal,
          );
        },
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.add,
            color: AppColors.secondary,
            size: 50,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        //color: AppColors.primary,
        child: BottomAppBar(
          notchMargin: 8.0,
          color: AppColors.secondary,
          clipBehavior: Clip.hardEdge,
          surfaceTintColor: AppColors.primary,
          shape: const CircularNotchedRectangle(),
        ),
      ),
    );
  }
}
