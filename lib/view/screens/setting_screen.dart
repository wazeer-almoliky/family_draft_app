import 'package:arabic_font/arabic_font.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/controller/stting_controller.dart';
import 'package:family/utilities/classes/custom_color_picker.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  void reload() {
    Get.put(SettingController()).getPrimaryColor();
    Get.put(SettingController()).update();
  }

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(SettingController());
    return Scaffold(
      appBar: DAppBar(
        title: "الإعـــدادات",
        back: AppColors.secondary,
        front: AppColors.primary,
        isHasSetting: false,
      ),
      body: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
              controller.logout();
              },
              title:const CustomText(text: "تسجيل خروج",fontSize: 18,),leading:const Icon(Icons.logout),),
          const  SizedBox(height: 20,),
         const Divider(height: 2.5,thickness: 3.9,),
         const  SizedBox(height: 20,),
            GetBuilder<SettingController>(
                init: SettingController(),
                builder: (innerController) {
                  return ListTile(
                    onTap: () async {
                      // CustomDatePicker.showColor(
                      //         defalut: Color(innerController.mainColor))
                      //     .then((value) {
                      //   innerController.changeColor(value);
                      //   innerController.update();
                      // });
                      // reload();
                    },
                    title: CustomText(
                      text: "تغيير اللـون الأساسي",
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 18,
                      colorText: AppColors.primary,
                    ),
                    leading: const Icon(
                      Icons.color_lens,
                      size: 28,
                    ),
                    trailing: ColorIndicator(
                        width: 40,
                        height: 40,
                        borderRadius: 0,
                        color: Color(innerController.mainColor),
                        elevation: 1,
                        onSelectFocus: true,
                        onSelect: () async {
                          CustomDatePicker.showColor(defalut: Color(innerController.mainColor)).then((value) async{
                            innerController.changeColor(value);
                            await Get.forceAppUpdate();
                            // innerController.update();
                          });
                          // reload();
                        }),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<SettingController>(
                builder: (controller) {
                  return ListTile(
                    onTap: () async {
                      // CustomDatePicker.showColor(
                      //         defalut: Color(innerController.mainColor2))
                      //     .then((value) {
                      //   innerController.changeColor2(value);
                      //   // innerController.update();
                      // });
                      // reload();
                    },
                    title: CustomText(
                      text: "تغيير اللـون الثانوي",
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 18,
                      colorText: AppColors.primary,
                    ),
                    leading: const Icon(
                      Icons.color_lens,
                      size: 28,
                    ),
                    trailing: ColorIndicator(
                        width: 40,
                        height: 40,
                        borderRadius: 0,
                        color: Color(controller.mainColor2),
                        elevation: 1,
                        onSelectFocus: false,
                        onSelect: () async {
                          CustomDatePicker.showColor(defalut: Color(controller.mainColor2)).then((value) async{
                            controller.changeColor2(value);
                           await Get.forceAppUpdate();
                            // innerController.update();
                          });
                          // reload();
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
