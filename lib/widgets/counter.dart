import 'package:flutter/material.dart';

class CustomCounter extends StatefulWidget {
  final String counterLabel;

  final double iconSize;
  final Color iconColor;
  final double counterHeight;
  final double counterWidth;
  final double counterLabelFontSize;
  final double counterTextFontSize;
  final Color counterTextColor;
  final double borderRadius;
  final Color borderColor;
  final Color counterColor;
  final Color displayColor;
  final ValueSetter<int> callback;

  const CustomCounter({
    super.key,
    this.counterLabel = 'Counter',
    this.iconSize = 20,
    this.iconColor = Colors.white,
    this.counterHeight = 20,
    this.counterWidth = 1,
    this.counterLabelFontSize = 20,
    this.counterTextFontSize = 20,
    this.counterTextColor = Colors.white,
    this.borderRadius = 10,
    this.borderColor = Colors.teal,
    this.counterColor = Colors.teal,
    this.displayColor = Colors.transparent,
    required this.callback,
  });

  @override
  State<CustomCounter> createState() {
    return _CustomCounterState();
  }
}

class _CustomCounterState extends State<CustomCounter> {
  int counter = 10;

  void _incrementCounter() {
    setState(() {
      counter++;
      widget.callback(counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      counter--;
      widget.callback(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 40,
          child: IconButton(
            iconSize: widget.iconSize,
            color: widget.iconColor,
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
          ),
        ),
        const VerticalDivider(),
        Text(
          '$counter',
          style: TextStyle(
              fontSize: widget.counterTextFontSize,
              color: widget.counterTextColor),
        ),
        const VerticalDivider(),
        SizedBox(
          width: 40,
          child: IconButton(
            iconSize: widget.iconSize,
            color: widget.iconColor,
            icon: const Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ),
      ],
    );
  }
}
