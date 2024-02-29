import 'package:arabic_font/arabic_font.dart';
import 'package:family/binding/signup_binding.dart';
import 'package:family/controller/login_controller.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/functions/form_validations.dart';
import 'package:family/view/screens/signup_screen.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<LoginController>();
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
          isHasSetting: false,
          height: 200,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: outerController.loginKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CustomText(
                      text: "تسجيــل الدخــول",
                      fontFamily: ArabicFont.dinNextLTArabic,
                      alignment: Alignment.center,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      colorText: AppColors.primary,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ...List.generate(
                        2,
                        (index) => GetBuilder<LoginController>(builder: (innerController){
                          return InputField(
                              label: index == 0
                                  ? "اسـم المستخـدم"
                                  : "كلمـة المـرور",
                              hint: index == 0
                                  ? "اسـم المستخـدم"
                                  : "كلمـة المـرور",
                              controller:
                                  outerController.listOfController(index),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              suffixIcon:index==0? const Icon(Icons.person_outline):IconButton(onPressed: (){
                                innerController.enablePassword();
                              }, icon:const Icon(Icons.remove_red_eye)),
                              isNumber: false,
                              isPassword:innerController.isEnablePassword&&index==1,
                              labelColor: AppColors.primary,
                              onValid: (val) {
                                return FormValidations.checkValidations(
                                    val!, 4, 25);
                              },
                            );
                        })
                            ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onPressed: () async {
                        outerController.login();
                      },
                      text: "تسجيــل",
                      buttonColor: AppColors.primary,
                      textColor: AppColors.secondary,
                      margin: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 35),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      fontSize: 22,
                      fontFamily: ArabicFont.dinNextLTArabic,
                      fontWeight: FontWeight.bold,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          Get.off(() => const SignUpScreen(),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease,
                              transition: Transition.upToDown,
                              binding: SignUpBinding());
                        },
                        child:  CustomText(
                          text: "لا أمتلك حســــاب بالفعل ؟",
                          alignment: Alignment.center,
                          fontFamily: ArabicFont.dubai,
                          fontSize: 18,
                          colorText: AppColors.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
