import 'dart:developer';

import 'package:family/controller/product_controller.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyProduct extends StatelessWidget {
  const FamilyProduct({super.key});
  void reload(){
    Get.put(ProductController()).fetchData();
  }
  @override
  Widget build(BuildContext context) {
  //  reload();
    final outerController = Get.put(ProductController());
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
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Obx(() {
                  if (outerController.remoteState.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return outerController.remoteState.servicesState.isEmpty
                        ? CustomText(
                            text: "لا يوجـــد بيانــات",
                            fontSize: 20,
                            colorContainer: AppColors.secondary,
                          )
                        : ListView.builder(
                          itemCount: outerController.remoteState.servicesState.length,
                          itemBuilder: (_, index) {
                            final data =
                                outerController.remoteState.servicesState;
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: AppColors.grayColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                onTap: (){
                                  log("${data[index].id}>>${ data[index].name!}");
                                  outerController.detailsViewScreen(id: data[index].id,name: data[index].name!,price: data[index].price!);
                                },
                                title: CustomText(text:data[index].name!,fontSize: 20,fontWeight: FontWeight.w900,),
                                trailing: Icon(Icons.arrow_circle_left,size: 40,color: AppColors.primary,),
                              ),
                            );
                          });
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
