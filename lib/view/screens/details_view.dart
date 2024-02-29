import 'package:arabic_font/arabic_font.dart';
import 'package:family/app_links.dart';
import 'package:family/controller/details_view_controller.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/screens/service_update_screen.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});
  void reload() {
    // Get.put(DetailsViewController()).remoteState.servicesState.clear();
  }
  @override
  Widget build(BuildContext context) {
    reload();
    final outerController = Get.put<DetailsViewController>(DetailsViewController());
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
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomText(
                    text: "اســم الخدمة:",
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
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CustomText(
                    text: "سعــر الخدمـة:",
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
              const Divider(
                height: 10,
                thickness: 4.4,
              ),
              const SizedBox(
                height: 20,
              ),
              if (outerController.user != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    final label = ["إضــافة صور", "تعديــل"];
                    return CustomButton(
                      onPressed: () {
                        if (index == 1) {
                          Get.to(() => const UpdateServiceScreen(),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                              transition: Transition.upToDown,
                              arguments: {
                                "label": "تعديــل",
                                "prID": outerController.id,
                                "price": outerController.price,
                                "serviceName": outerController.name,
                                "catID": outerController.catID,
                                "photoID": 0
                              });
                        } else {
                          Get.to(() => const UpdateServiceScreen(),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                              transition: Transition.upToDown,
                              arguments: {
                                "label": "إضـافـــة",
                                "prID": outerController.id,
                                "price": outerController.price,
                                "serviceName": outerController.name,
                                "photoID": 1
                              });
                        }
                      },
                      text: label[index],
                      fontFamily: ArabicFont.avenirArabic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      buttonColor: AppColors.secondary,
                      textColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    );
                  }),
                ),
              const SizedBox(
                height: 20,
              ),
              if (outerController.user != "ادمن")
                Obx(() {
                 
                  return GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 2,
                    children: List.generate(
                        outerController.remoteState.photoState.length,
                        (index) => InkWell(
                          onTap: (){
                            Get.to(() => const UpdateServiceScreen(),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease,
                              transition: Transition.upToDown,
                              arguments: {
                                "label": "تعديــل",
                                "prID": outerController.id,
                                "price": outerController.price,
                                "serviceName": outerController.name,
                                "catID": outerController.catID,
                                "photoID": outerController.remoteState.photoState[index].id
                              });
                          },
                          child: Container(
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: AppColors.grayColor,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "${AppLinks.upload}/${outerController.remoteState.photoState[index].name!}")),
                                ),
                                // child: PhotoView(
                                //   imageProvider: NetworkImage(
                                //       "${AppLinks.upload}/${data[index].name!}"),
                                // ),
                              ),
                        )),
                  );
                }),
            ],
          )),
    );
  }
}
