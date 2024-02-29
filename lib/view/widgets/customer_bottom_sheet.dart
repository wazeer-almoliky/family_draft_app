import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/reserve_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_date_picker.dart';
import 'package:family/utilities/classes/custom_drop_down_search.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerButtomSheet {
  static final controller = Get.put(ReserveController());
  //static final controller2 = Get.put(DetailsViewController2());
  static void customerSheet(int id,int price ,{String? title}) async {
    await Get.bottomSheet(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: Get.height - 150,
          // color: AppColors.grayColor,
          child: Column(
            children: [
             const SizedBox(height: 30,),
              CustomText(
                text: "حجـــز $title",
                fontSize: 27,
                fontFamily: ArabicFont.avenirArabic,
                fontWeight: FontWeight.bold,
                colorText: AppColors.primary,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2.2,
                thickness: 4,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: controller.reserveKey,
                      child: Column(
                        children: List.generate(
                            InputFieldData.customerPeriod.length, (index) {
                          return InputField(
                            controller: controller.listOfController(index),
                            label: InputFieldData.customerPeriod[index].label,
                            hint: InputFieldData.customerPeriod[index].label,
                            suffixIcon:
                                Icon(InputFieldData.customerPeriod[index].icon),
                            isNumber: true,
                            isReadOnly:
                                InputFieldData.customerPeriod.length - 1 ==
                                    index,
                            onTap: () async {
                              if (InputFieldData.customerPeriod.length - 1 ==
                                  index) {
                                final date = await CustomDatePicker.showDate();
                                controller.date.text =
                                    date.toString().substring(0, 10);
                                controller.update();
                              }
                            },
                            onValid: (val) {
                              return FormValidations.checkValidations(
                                  val!,
                                  InputFieldData.customerPeriod[index].min!,
                                  InputFieldData.customerPeriod[index].max!);
                            },
                            onChanged: (val) {
                              if (index == 2) {
                                controller.price(int.tryParse(val) ?? 0);
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
                        CustomDropDownSearch(
                          items: controller.listOfPayment,
                          labelText: "طــرق الدفع",
                          hintText: "طــرق الدفع",
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          onChanged: (val) {
                            if (val == null) {
                              return;
                            }
                            controller.listOfDropBoxValue[0] = val;
                          },
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                     
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  // Get.put(ReserveController()).checkFromUser();
                  controller.request(id,price);
                },
                text: "حجـــز",
                fontFamily: ArabicFont.avenirArabic,
                fontSize: 25,
                radius: 10,
                buttonColor: AppColors.primary,
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondary,
                
                padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 13),
                // margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              const SizedBox(
                height: 20,
              ),
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
