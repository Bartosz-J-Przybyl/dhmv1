

import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.color, required this.masure,
  });
  final Color color;
  final double masure;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: masure,
      height: masure,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Color.fromARGB(255, 50, 58, 60), Colors.black87],
          center: AlignmentDirectional(0.05, 0.05),
          focal: AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: [0.75, 1.0],
        ),
      ),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0, 0.45],
              colors: [
                const Color.fromARGB(255, 50, 58, 60).withOpacity(0),
                const Color.fromARGB(255, 50, 58, 60)
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.55, 1],
              colors: [
                const Color.fromARGB(255, 50, 58, 60).withOpacity(0),
                const Color.fromARGB(255, 50, 58, 60)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
}
