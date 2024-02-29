import 'package:arabic_font/arabic_font.dart';
import 'package:family/app_links.dart';
import 'package:family/controller/details_view_controller2.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:family/view/widgets/customer_bottom_sheet.dart';
import 'package:family/view/widgets/normal_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class DetailsView2 extends StatelessWidget {
  const DetailsView2({super.key});
  void reload() {
    Get.find<DetailsViewController2>().remoteState.photoState.clear();
    Get.find<DetailsViewController2>().remoteState.servicesState.clear();
  }

  @override
  Widget build(BuildContext context) {
    // reload();
    final outerController = Get.find<DetailsViewController2>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: DAppBar(
        title: outerController.name,
        back: AppColors.secondary,
        front: AppColors.primary,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomText(
                    text: "اســم المنتـج:",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: outerController.name!,
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomText(
                    text: "سعــر المنتـج:",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "${outerController.price!}",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              const Divider(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              //if (outerController.remoteState.servicesState.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onPressed: () {
                      if (outerController.storage!.read("customerName") !=
                          null) {
                        CustomerButtomSheet.customerSheet(
                            outerController.remoteState.servicesState[0].id ??
                                0,
                            outerController.price!,
                            title: outerController
                                .remoteState.servicesState[0].name);
                      } else {
                        //log();
                        NormalUserWidget.normalUser(
                            outerController.remoteState.servicesState[0].id ??
                                0,
                            outerController.remoteState.servicesState[0].name!);
                      }
                    },
                    text: "حجـــــز",
                    fontFamily: ArabicFont.avenirArabic,
                    fontSize: 20,
                    radius: 10,
                    fontWeight: FontWeight.bold,
                    buttonColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                final data = outerController.remoteState.photoState;
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 2,
                  children: List.generate(
                      data.length,
                      (index) => Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: AppColors.grayColor,
                              borderRadius: BorderRadius.circular(20),
                              // image: DecorationImage(
                              //     image: NetworkImage(
                              //         "${AppLinks.upload}/${outerController.remoteState.photoState[index].name!}")),
                            ),
                            child: PhotoView(
                              imageProvider: NetworkImage(
                                  "${AppLinks.upload}/${data[index].name!}"),
                            ),
                          )),
                );
              }),
            ],
          )),
    );
  }
}
