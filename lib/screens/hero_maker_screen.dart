import 'package:flutter/material.dart';

class HeroMakerScreen extends StatefulWidget {
  const HeroMakerScreen({super.key});

  @override
  State<HeroMakerScreen> createState() => _HeroMakerScreenState();
}

class _HeroMakerScreenState extends State<HeroMakerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Icon(Icons.abc)]),
    );
  }
}
