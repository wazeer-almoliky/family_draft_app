import 'package:arabic_font/arabic_font.dart';
import 'package:family/controller/section_service_cpntroller.dart';
import 'package:family/utilities/classes/custom_input_field.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionService extends StatelessWidget {
  const SectionService({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<SectionServiceController>();
    return Scaffold(
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            children: [
              InputField(
                controller: outerController.search,
                label: "بحــث",
                hint: "بحــث",
                // isNumber: false,
                onChanged: (val) => outerController.filterCategory(val),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child:  Obx(() {
                        if (outerController.remoteState.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          final data = outerController.allFamily;
                          return data.isEmpty
                              ? CustomText(
                                  text: "لا يوجـــد بيانــات",
                                  fontSize: 20,
                                  colorContainer: AppColors.secondary,
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 20,
                                  children: List.generate(
                                      outerController.allFamily.length,
                                      (index) {
                                    return Container(
                                      width: Get.width / 2 - 150,
                                      height: (Get.width / 2 - 50) / 2,
                                      clipBehavior: Clip.hardEdge,
                                      margin: const EdgeInsets.only(
                                          bottom: 10, right: 12, left: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                index.isEven ? 30 : 0),
                                            bottomRight: Radius.circular(
                                                index.isEven ? 30 : 0),
                                            topRight: Radius.circular(
                                                index.isOdd ? 30 : 0),
                                            bottomLeft: Radius.circular(
                                                index.isOdd ? 30 : 0),
                                          ),
                                          // border: Border.all(
                                          //     color: AppColors.primary),
                                          color: AppColors.secondary),
                                      child: Material(
                                        color: AppColors.transparentColor,
                                        child: InkWell(
                                          splashColor: const Color.fromARGB(
                                              255, 189, 189, 189),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          onTap: () {
                                            outerController.detailsViewScreen(
                                                id: outerController
                                                    .allFamily[index].id!,
                                                name: outerController
                                                    .allFamily[index].name!);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                text: outerController
                                                    .allFamily[index].name!,
                                                fontFamily:
                                                    ArabicFont.avenirArabic,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                colorText: AppColors.primary,
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              CustomText(
                                                text: outerController
                                                    .allFamily[index].address!,
                                                fontFamily:
                                                    ArabicFont.avenirArabic,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                colorText: AppColors.primary,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                        }
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
