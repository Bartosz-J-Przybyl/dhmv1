import 'package:flutter/material.dart';

class CustomClipperClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 50, 0);
    path.lineTo(size.width - 90, size.height / 2);
    path.lineTo(size.width - 130, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
