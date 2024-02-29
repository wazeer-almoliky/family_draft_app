import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/user_controller.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/screens/update_screen.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatelessWidget {
  //Get.forceAppUpdate();
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.put<UserController>(UserController());
    return Scaffold(
      appBar: DAppBar(
        title: "المــدراء",
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Obx(() {
            if (outerController.remoteState.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final user = outerController.remoteState.userState
                  .where((u) => u.type == "ادمن")
                  .toList();
              return ListView.builder(
                  itemCount: user.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.only(bottom: 25),
                      decoration: BoxDecoration(
                          color: AppColors.grayColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: user[index].name!,
                            fontSize: 20,
                            fontFamily: ArabicFont.avenirArabic,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  Get.to(() => const UpdateScreen(),
                                      duration:
                                          const Duration(milliseconds: 400),
                                      transition: Transition.fadeIn,
                                      curve: Curves.ease,
                                      arguments: {
                                        "label": "تعديل",
                                        "userID": user[index].id!,
                                        "name": user[index].name!
                                      });
                                },
                                text: "تعــديل",
                                fontSize: 19,
                                radius: 12,
                                buttonColor: AppColors.primary,
                                textColor: AppColors.secondary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                              ),
                              CustomButton(
                                onPressed: () {
                                  outerController.deleteUser(user[index].id!);
                                },
                                text: "حــذف",
                                fontSize: 19,
                                radius: 12,
                                buttonColor: AppColors.primary,
                                textColor: AppColors.secondary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                              ),
                              CustomButton(
                                onPressed: () {
                                  outerController.stopUser(user[index].id!);
                                },
                                text: "ايقــاف",
                                fontSize: 19,
                                radius: 12,
                                buttonColor: AppColors.primary,
                                textColor: AppColors.secondary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    );
                  });
            }
          })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.transparentColor,
        elevation: 0.0,
        onPressed: () {
          // CustomAlertDialog.show();
          Get.to(() => const UpdateScreen(),
              duration: const Duration(milliseconds: 400),
              transition: Transition.fadeIn,
              curve: Curves.ease,
              arguments: {"label": "اضافة", "userID": 0});
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
