import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dhmv1/screens/hero_maker_screen.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<BottomTabBar> {
  int selectedpage = 1;
  get primaryColor => null;

  final _pageNo = [
    const Scaffold(),
    const HeroMakerScreen(),
    const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageNo[selectedpage],
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedpage,
        backgroundColor: Colors.teal,
        buttonBackgroundColor: const Color.fromARGB(255, 10, 207, 188),
        color: const Color.fromARGB(255, 10, 207, 188),
        height: 55,
        items: const <Widget>[
          Image(
            image: AssetImage("lib/assets/images/sb.png"),
            width: 45,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: AssetImage("lib/assets/images/d20.png"),
            width: 45,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: AssetImage("lib/assets/images/rd.png"),
            width: 45,
            fit: BoxFit.scaleDown,
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }
}
