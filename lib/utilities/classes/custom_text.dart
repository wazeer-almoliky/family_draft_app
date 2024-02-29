import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:family/utilities/constants/app_colors.dart';

class CustomText extends StatelessWidget {
  final double? width;
  final AlignmentGeometry? alignment;
  final String text;
  final String? fontFamily;
  final Color? colorText, colorContainer;
  final double? fontSize;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? margin;
  final FontWeight? fontWeight;
  final bool? isHaveBorder;

  const CustomText(
      {Key? key,
      required this.text,
      this.width,
      this.alignment,
      this.fontFamily,
      this.colorText,
      this.colorContainer,
      this.fontSize,
      this.textAlign,
      this.margin,
      this.fontWeight,
      this.isHaveBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: alignment,
      margin: margin,
      decoration: BoxDecoration(
          border: isHaveBorder == false
              ? null
              : const Border(
                  bottom:
                      BorderSide(color: AppColors.transparentColor, width: 2))),
      child: Text(text,
          style: ArabicTextStyle(
              color: colorText,
              fontSize: fontSize,
              arabicFont: fontFamily ?? ArabicFont.changa,
              fontWeight: fontWeight,
              overflow: TextOverflow.fade),
          softWrap: true,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis),
    );
  }
}
