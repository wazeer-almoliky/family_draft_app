import 'dart:developer';
import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/request_controller.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_dialog.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.put<ResquestController>(ResquestController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: "الحجــوزات",
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
            final user = outerController.admin == "ادمن"
                ? outerController.remoteState.userState
                    .where((user) =>
                        user.state == 0 && outerController.userState == 0)
                    .toList()
                : outerController.remoteState.reserveState
                    .where((res) =>
                        res.state == 0 && outerController.userState == 0)
                    .toList();
            final user2 = outerController.admin == "ادمن"
                ? outerController.remoteState.userState
                    .where((user) =>
                        user.state == 1 && outerController.userState == 1)
                    .toList()
                : outerController.remoteState.reserveState
                    .where((res) =>
                        res.state == 1 &&res.type != "ادمن" && outerController.userState == 1)
                    .toList();

            if (user.isEmpty && outerController.userState == 0) {
              return const Center(
                child: CustomText(
                  text: "لا يوجــد",
                  fontSize: 22,
                ),
              );
            }
            if (user2.isEmpty && outerController.userState == 1) {
              return const Center(
                child: CustomText(
                  text: "لا يوجــد",
                  fontSize: 22,
                ),
              );
            } else {
              return ListView.builder(
                itemCount:
                    outerController.userState == 1 ? user2.length : user.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondary),
                    child: Material(
                      color: AppColors.transparentColor,
                      child: InkWell(
                        onTap: () {
                          // log("${user[index].id}==${user[index].name}==${user[index].state}");
                        },
                        splashColor: const Color.fromARGB(255, 189, 189, 189),
                        borderRadius: BorderRadius.circular(35),
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
                                    text: outerController.userState == 1
                                        ? user2[index].name!
                                        : user[index].name!,
                                    colorText: AppColors.primary,
                                    fontFamily: ArabicFont.elMessiri,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            
                              const Divider(
                                height: 1.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (outerController.userState == 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                          // color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: InkWell(
                                          child: Row(
                                        children: List.generate(2, (index2) {
                                          return CustomButton(
                                            onPressed: () async {
                                              if (index2 == 0) {
                                                if (outerController.admin ==
                                                    "ادمن") {
                                                  CustomAlertDialog.demoDetail(
                                                    user[index].name!,
                                                    user[index].state!,
                                                    user[index].id!,
                                                  );
                                                } else {
                                                  log("${ user[index].id!}");
                                                  CustomAlertDialog.demoDetail(
                                                    user[index].name!,
                                                    outerController
                                                        .remoteState
                                                        .reserveState[index]
                                                        .state!,
                                                    user[index].id!,
                                                    count: outerController
                                                        .remoteState
                                                        .reserveState[index]
                                                        .quentity,
                                                    date: outerController
                                                        .remoteState
                                                        .reserveState[index]
                                                        .date
                                                        .toString()
                                                        .substring(0, 10),
                                                    isNotAdmin: true,
                                                  );
                                                }
                                              } else {
                                                final phone =
                                                    outerController.admin ==
                                                            "ادمن"
                                                        ? outerController
                                                            .remoteState
                                                            .userState[index]
                                                            .phone
                                                        : outerController
                                                            .remoteState
                                                            .reserveState[index]
                                                            .phone;
                                                final url = Uri(
                                                    scheme: "tel",
                                                    path: "+$phone");
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }
                                            },
                                            text: index2 == 0
                                                ? "تــأكيــد"
                                                : "اتصـــال",
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
                                      )),
                                    ),
                                  ],
                                ),
                              if (outerController.userState == 1 &&
                                  outerController.admin == "ادمن")
                                Center(
                                  child: CustomButton(
                                    onPressed: () {
                                      log("${outerController
                                              .remoteState.userState[index].id!}");
                                      outerController.updateUser(
                                          outerController
                                              .remoteState.userState[index].id!,
                                          disableUser: 0,hint: "الإيقــاف");
                                    },
                                    text: "ايقـــاف",
                                    radius: 10,
                                    buttonColor: AppColors.primary,
                                    textColor: AppColors.secondary,
                                    fontSize: 19,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                  ),
                                ),

                                
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        }),
      ),
    );
  }
}
