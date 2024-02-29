import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:family/controller/dashboard_controller.dart';
import 'package:family/model/static/dashboard_model.dart';
import 'package:family/utilities/classes/custom_buttom.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/widgets/app_bar.dart';
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final outerController = Get.find<DashboardController>();
    return Scaffold(
      backgroundColor:
          AppColors.whiteColor, //"إدارة التحكــم ${outerController.admin}"
      appBar:  DAppBar(
        title: outerController.admin == "عادي"?"إدارة الحســاب":"الإدارة",
        back: AppColors.secondary,
        front: AppColors.primary,
        isHasSetting: true,
      ),
      body: Center(
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: outerController.admin == "عادي"
                ? DashBoardData.user.length
                : DashBoardData.admin.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: CustomButton(
                      onPressed: () {
                        outerController.pages(index);
                      },
                      text: outerController.admin == "عادي"
                          ? DashBoardData.user[index].label
                          : DashBoardData.admin[index].label,
                      fontSize: 20,
                      radius: 10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 9),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      buttonColor: AppColors.whiteColor,
                      textColor: AppColors.primary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      
    );
  }
}
