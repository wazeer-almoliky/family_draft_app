import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
 final IconData? icon;
 final Color? color;
 final double? size;
 final EdgeInsetsGeometry? margin,padding;
 final AlignmentGeometry? alignment;
  const CustomIcon({
    Key? key,
   required this.icon,
    this.color,
    this.size,
    this.margin,
    this.padding,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: margin,
            padding: padding,
            alignment: alignment,
      child: Icon(icon,color: color,size:size ,),
    );
  }
}
