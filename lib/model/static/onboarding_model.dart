import 'package:family/utilities/constants/app_images.dart';

class OnboardingModel {
  final String? image, title, body;
  const OnboardingModel(
      { this.image,  this.title,  this.body});
}
class OnboardingModelList {
  static List<OnboardingModel> onboardingModelList = const[
    OnboardingModel(image: AppImages.logo,title: "الشريحة الأولى",body: "الشريحة الأولى"),
    OnboardingModel(image: AppImages.logo,title: "الشريحة الثانية",body: "الشريحة الثانية"),
    OnboardingModel(image: AppImages.logo,title: "الشريحة الثالثة",body: "الشريحة الثالثة"),
    OnboardingModel(image: AppImages.logo,title: "الشريحة الرابعة",body: "الشريحة الرابعة"),
  ];
}
