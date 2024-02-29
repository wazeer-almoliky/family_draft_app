import 'package:flutter/material.dart';
import 'package:family/utilities/constants/app_colors.dart';
class RPSCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) { 
  Paint paint0 = Paint()
      ..color =  AppColors.primary
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    Path path0 = Path();
    path0.moveTo(size.width*0.0016000,size.height*0.9913500);
    path0.lineTo(0,size.height*0.2378000);
    path0.lineTo(size.width*0.0844000,size.height*0.5199500);
    path0.lineTo(size.width*0.2577250,size.height*0.5609500);
    path0.lineTo(size.width*0.3316500,size.height*0.6447500);
    path0.lineTo(size.width*0.4248250,size.height*0.7488000);
    path0.lineTo(size.width*0.5734750,size.height*0.7458000);
    path0.lineTo(size.width*0.6649250,size.height*0.6474500);
    path0.lineTo(size.width*0.7353500,size.height*0.5472000);
    path0.lineTo(size.width*0.9102000,size.height*0.5229000);
    path0.lineTo(size.width*0.9975000,size.height*0.2500000);
    path0.lineTo(size.width*0.9975000,size.height*0.9900000);
    path0.lineTo(size.width*0.0016000,size.height*0.9913500);
    path0.close();
    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}