import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/reserve_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_date_picker.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReserveScreen extends StatelessWidget {
  const 
  ReserveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //reload();
    final outerterController = Get.find<ReserveController>();
    return Scaffold(
      appBar: DAppBar(
        title: outerterController.name1,
        back: AppColors.primary,
        front: AppColors.secondary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: AppColors.grayColor,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 25,
            ),
            Form(
              key: outerterController.reserveKey,
              child: Column(
                children: List.generate(InputFieldData.customerPeriod.length,
                    (index) {
                  return InputField(
                    controller: outerterController.listOfController(index),
                    label: InputFieldData.customerPeriod[index].label,
                    hint: InputFieldData.customerPeriod[index].label,
                    suffixIcon: Icon(InputFieldData.customerPeriod[index].icon),
                    isNumber: index > 1,
                    isReadOnly:
                        InputFieldData.customerPeriod.length - 1 == index,
                    onTap: () async {
                      if (InputFieldData.customerPeriod.length - 1 == index) {
                        final date = await CustomDatePicker.showDate();
                        outerterController.date.text =
                            date.toString().substring(0, 10);
                        outerterController.update();
                      }
                    },
                    onValid: (val) {
                      return FormValidations.checkValidations(
                          val!,
                          InputFieldData.customerPeriod[index].min!,
                          InputFieldData.customerPeriod[index].max!);
                    },
                    onChanged: (val) {
                      if (index == 3) {
                        outerterController.price(int.tryParse(val)!);
                      }
                    },
                  );
                }),
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                // ...List.generate(
                //     1,
                //     (index) => Obx(() {
                //           return CustomDropDownSearch(
                //             items: outerterController.listOfString(index),
                //             labelText:  "طــرق الدفع",
                //             hintText:  "طــرق الدفع",
                //             margin: const EdgeInsets.symmetric(vertical: 10),
                //             onChanged: (val) {
                //               if (val == null) {
                //                 return;
                //               }
                //               controller.listOfDropBoxValue[index] = val;
                //               // if (index == 0) {
                //               //   controller.price(
                //               //       controller.remoteState.getPrice(val),
                //               //       isFromDrop: true);
                //               //   controller.listOfDropBoxValue[index] = val;
                //               // } else {
                //               //   controller.listOfDropBoxValue[index] = val;
                //               // }
                //             },
                //           );
                //         })),
                // Obx(() {
                //   if (outerterController.remoteState.isLoading.value) {
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else {
                //     return CustomDropDownSearch(
                //       items: outerterController.listOfDataService(),
                //       // labelText: "نــوع الخدمـة",
                //       hintText: "نــوع الخدمـة",
                //       margin: const EdgeInsets.only(bottom: 15),
                //       onChanged: (val) {
                //         if (val != null) {
                //           // outerterController.valueOfDropDownBox(val);
                //           // outerterController.update();
                //         }
                //       },
                //     );
                //   }
                // }),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: "السعــر : ${outerterController.value}",
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {},
                  text: "حجـــز",
                  fontFamily: ArabicFont.avenirArabic,
                  fontSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
