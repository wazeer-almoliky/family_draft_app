import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin, padding;
  final void Function() onPressed;
  final Color? textColor, buttonColor;
  final String? text;
  final double? fontSize,radius;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const CustomButton(
      {Key? key,
      this.margin,
      this.padding,
      this.radius,
      required this.onPressed,
      this.textColor,
      this.buttonColor,
      this.text,
      this.fontFamily,
      this.fontWeight,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
          onPressed: onPressed,
          textColor: textColor,
          color: buttonColor,
          padding: padding,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius??30),
              side:  BorderSide(
                  color: textColor?? AppColors.blackColor,
                  strokeAlign: BorderSide.strokeAlignInside,width: 1.9)),
          child: CustomText(
            text: text!,
            fontSize: fontSize ?? 18,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
          )),
    );
  }
}
