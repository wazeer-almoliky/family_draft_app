
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
 final IconData? icon;
 final Color? color;
 final double? size;
 final EdgeInsetsGeometry? margin,padding;
 final AlignmentGeometry? alignment;
 final void Function()? onPressed;
 final String? tooltip;
  const CustomIconButton({
    Key? key,
  required this.onPressed,
   required this.icon,
    this.color,
    this.size,
    this.margin,
    this.padding,
    this.alignment,
    this.tooltip
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: margin,
            padding: padding,
            alignment: alignment,
      child: IconButton(onPressed: onPressed, icon: Icon(icon,color: color,size:size ,),tooltip:tooltip ,),
    );
  }
}
