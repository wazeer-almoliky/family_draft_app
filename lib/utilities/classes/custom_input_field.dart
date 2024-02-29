import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:family/utilities/classes/custom_text.dart';
import 'package:family/utilities/constants/app_colors.dart';

class InputField extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final bool? isNumber, isReadOnly, isPassword;
  final String? label, hint;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? onValid;
  final Widget? suffixIcon;
  final Color? labelColor;
  const InputField(
      {super.key,
      this.label,
      this.hint,
      this.margin,
      this.controller,
      this.isNumber = false,
      this.isReadOnly = false,
      this.isPassword = false,
      this.onChanged,
      this.onTap,
      this.onValid,
      this.labelColor,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber == true
            ? const TextInputType.numberWithOptions()
            : TextInputType.text,
        readOnly: isReadOnly == true ? true : false,
        obscureText: isPassword == false || isPassword == null ? false : true,
        style: ArabicTextStyle(
            arabicFont: ArabicFont.tajawal,
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: labelColor ?? AppColors.primary),
        textInputAction:TextInputAction.next,
        onChanged: onChanged,
        onTap: onTap,
        validator: onValid,
        decoration: InputDecoration(
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                    text: label ?? '',
                    fontFamily: ArabicFont.tajawal,
                    fontSize: 15,
                    colorText: labelColor ?? AppColors.primary)),
            hintText: hint,
            hintStyle: ArabicTextStyle(
                arabicFont: ArabicFont.tajawal,
                fontSize: 13,
                color: labelColor ?? AppColors.primary),
            suffixIcon: suffixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 30),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:  BorderSide(color: AppColors.secondary))),
      ),
    );
  }
}
