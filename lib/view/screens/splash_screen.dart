import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/controller/splashscreencontroller.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/utilities/constants/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: const AssetImage(AppImages.logo),
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
