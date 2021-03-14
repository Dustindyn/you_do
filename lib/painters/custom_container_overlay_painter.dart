import 'package:flutter/material.dart';

class CustomContainerOverlayPainter extends CustomPainter {
  Color color;
  CustomContainerOverlayPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width*.75, size.height*.97);
    path.lineTo(size.width*.73, size.height);
    path.quadraticBezierTo(
    size.width*.85, size.height / 2, size.width*.75, size.height*.03);
    path.lineTo(size.width*.73, 0);
    path.lineTo(size.width*.945, 0);
    path.quadraticBezierTo(
      size.width, size.height*.035, size.width, size.height*.15
    );
    path.lineTo(size.width, size.height*.85);
    path.quadraticBezierTo(size.width, size.height, size.width*.945, size.height);
    path.lineTo(size.width*.73, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}