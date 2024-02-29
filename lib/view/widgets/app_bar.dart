import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:family/view/screens/setting_screen.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? back, front;
  final bool? isHasSetting;
  final double? height;
  const DAppBar(
      {super.key, this.title, this.back, this.front, this.isHasSetting = true,this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0.0,
      toolbarHeight: height??140,
      backgroundColor: AppColors.whiteColor,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
          height: height??150,
          width: Get.width,
          color: front,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           if (isHasSetting == true)   const Spacer(
                flex: 1,
              ),
              Center(
                  child: CustomText(
                text: title!,
                fontFamily: ArabicFont.tajawal,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                colorText: back,
              )),
             if (isHasSetting == true) const Spacer(),
              if (isHasSetting == true)
                IconButton(
                    onPressed: () {
                      Get.to(() => const SettingScreen(),
                          duration: const Duration(milliseconds: 550),
                          curve: Curves.ease,
                          transition: Transition.upToDown);
                    },
                    icon:const Icon(
                      Icons.settings,
                      size: 40,
                      color: AppColors.whiteColor,
                    ))
            ],
          ),
        ),
        
      ),
    
    );
  }

  @override
  Size get preferredSize => Size(Get.width, kToolbarHeight * 2);
}
