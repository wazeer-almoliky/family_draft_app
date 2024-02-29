import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/signup_controller.dart';
import 'package:family/model/static/input_field_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<SignUpController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: DAppBar(
          title: "",
          back: AppColors.secondary,
          front: AppColors.primary,
        ),
        body: SafeArea(
            child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          children: [
            Form(
              key: outerController.signUpKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  CustomText(
                    text: "انشــاء حســــاب",
                    fontFamily: ArabicFont.dinNextLTArabic,
                    alignment: Alignment.center,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ...List.generate(InputFieldData.signUp.length, (index) {
                    return GetBuilder<SignUpController>(
                        builder: (innerController) {
                      return InputField(
                        label: InputFieldData.signUp[index].label,
                        hint: InputFieldData.signUp[index].label,
                        suffixIcon: index != 1
                            ? Icon(InputFieldData.signUp[index].icon)
                            : IconButton(
                                onPressed: () {
                                  innerController.enablePassword();
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                        controller: outerController.listOfController(index),
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        isPassword: innerController.isEnablePassword&& index == 1,
                        isNumber: InputFieldData.signUp.length - 1 == index,
                        labelColor: AppColors.primary,
                        onValid: (val) {
                          return FormValidations.checkValidations(
                              val!,
                              InputFieldData.signUp[index].min!,
                              InputFieldData.signUp[index].max!);
                        },
                      );
                    });
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onPressed: () async {
                      outerController.signUp();
                    },
                    text: "حفــــــــظ",
                    buttonColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    margin: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 35),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    fontSize: 25,
                    fontFamily: ArabicFont.elMessiri,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
