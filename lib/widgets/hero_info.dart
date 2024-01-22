import 'package:flutter/material.dart';

class HeroInfo extends StatefulWidget {
  const HeroInfo({super.key});

  @override
  State<HeroInfo> createState() => _HeroInfoState();
}

double boxHight = 100;

class _HeroInfoState extends State<HeroInfo> {
  void _expand() {
    setState(() {
      if (boxHight == 180) {
        boxHight = 100;
      } else {
        boxHight = 180;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _expand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: boxHight,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 50, 58, 60),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 16.0,
              offset: const Offset(-6.0, -6.0),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
