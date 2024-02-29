import 'package:arabic_font/arabic_font.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:family/app_links.dart';
import 'package:family/binding/dashboard_binding.dart';
import 'package:family/binding/login_binding.dart';
import 'package:family/binding/signup_binding.dart';
import 'package:family/controller/home_controller.dart';
import 'package:family/controller/login_controller.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
// import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/screens/dashboard.dart';
import 'package:family/view/screens/login_screen.dart';
import 'package:family/view/screens/setting_screen.dart';
import 'package:family/view/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<HomeController>();
    final outerController2 = Get.put<LoginController>(LoginController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0.0,
        toolbarHeight: 120,
        flexibleSpace: ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 150,
            width: Get.width,
            color: AppColors.primary,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                CustomText(
                  text: "الرئيسيــة",
                  fontFamily: ArabicFont.avenirArabic,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.secondary,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "الحسـاب وتسجيل الدخول",
                          titleStyle: const ArabicTextStyle(arabicFont: ArabicFont.avenirArabic,fontSize: 22,fontWeight: FontWeight.bold),
                          content: Column(
                            children: [
                              ListTile(
                                onTap: () async {
                                  Get.back();
                                  if (outerController2.storage!
                                          .read("userID") !=
                                      null) {
                                    await Get.to(() => const Dashboard(),
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.ease,
                                        transition:
                                            Transition.leftToRightWithFade,
                                        binding: DashboardBinding());
                                    outerController2.update();
                                  } else {
                                    await Get.to(
                                      () =>
                                          const LoginScreen(), //const Dashboard(),
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                      transition: Transition.leftToRight,
                                      binding: LoginBinding(),
                                    );
                                    outerController2.update();
                                  }
                                },
                                title: const CustomText(
                                    text: "الدخول كحساب أعمال"),
                                leading: const Icon(
                                  Icons.login,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 2.5,
                                thickness: 4.1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const SignUpScreen(),
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.ease,
                                      transition: Transition.upToDown,
                                      binding: SignUpBinding());
                                },
                                title:
                                    const CustomText(text: "إنشاء حساب أعمال"),
                                leading: const Icon(
                                  Icons.login,
                                  size: 30,
                                ),
                              ),
                              const Divider(
                                height: 2.5,
                                thickness: 4.1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const SettingScreen(),
                                      duration:
                                          const Duration(milliseconds: 550),
                                      curve: Curves.ease,
                                      transition: Transition.upToDown);
                                },
                                title: const CustomText(text: "الإعدادات"),
                                leading: const Icon(
                                  Icons.settings,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: AppColors.grayColor);
                    },
                    icon: const Icon(
                      Icons.account_circle,
                      size: 40,
                      color: AppColors.whiteColor,
                    ))
              ],
            )),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: outerController.search,
              label: "بحــث",
              hint: "بحــث",
              // isNumber: false,
              onChanged: (val) => outerController.filterCategory(val),
            ),
            const SizedBox(
              height: 2,
            ),
           
            Obx(
              () => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 200,
                  // color: Colors.grey,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        reverse: true,
                        height: 200.0,
                        autoPlay: true,
                        autoPlayCurve: Curves.easeIn,
                        scrollDirection: Axis.vertical,
                        autoPlayInterval: const Duration(milliseconds: 3500),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.zoom),
                    items: outerController.remoteState.serviceState.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "${AppLinks.upload}/${i.url}"))),
                          );
                        },
                      );
                    }).toList(),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomText(text: "الأصناف",fontSize: 20,fontWeight: FontWeight.bold,),
           const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() {
                if (outerController.remoteState.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return outerController.allCategory.isEmpty
                      ? Center(
                          child: CustomText(
                            text: "لا توجـــد بيانــات",
                            fontSize: 20,
                            fontFamily: ArabicFont.avenirArabic,
                            colorContainer: AppColors.secondary,
                          ),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                              outerController.allCategory.length, (index) {
                            return InkWell(
                              onTap: () {
                                outerController.sectionServiceViewScreen(
                                    id: outerController
                                        .remoteState.serviceState[index].id,
                                    name: outerController
                                        .remoteState.serviceState[index].name,
                                    index: 0);
                              },
                              child: Container(
                                  width: Get.width / 2 - 150,
                                  height: Get.width / 2 - 50,
                                  clipBehavior: Clip.hardEdge,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: AppColors.grayColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Container(
                                          width: Get.width,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              color: AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.network(
                                            "${AppLinks.upload}/${outerController.allCategory[index].url}",
                                            // width: 200,

                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          child: Container(
                                            color: AppColors.primary,
                                            // alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            child: CustomText(
                                              text: outerController
                                                  .allCategory[index].name!,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              colorContainer: AppColors.primary,
                                              colorText: AppColors.whiteColor,
                                              // alignment: Alignment.bottomCenter,
                                              width: Get.width,
                                            ),
                                          )),
                                    ],
                                  )),
                            );
                          }),
                        );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
