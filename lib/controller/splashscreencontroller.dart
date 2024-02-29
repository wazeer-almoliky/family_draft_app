import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family/view/screens/user_decided.dart';
class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit(){
    animationInitilization();
    super.onInit();
  }
 @override
 void onReady(){
  super.onReady();
  toAnotherPage();
 }
  animationInitilization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    animationController.forward();
    // await toAnotherPage();
  }
  toAnotherPage() async{
    
   await Future.delayed(const Duration(seconds: 4),(){
    Get.to(
      transition: Transition.upToDown,
      curve: Curves.ease,
     duration:const Duration(milliseconds:600),
      ()=>const UserDecided(),
      // binding: OnBoardingBinding()
      );
   }) ;
  
  }
}