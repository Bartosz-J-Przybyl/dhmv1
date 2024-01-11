import 'package:dhmv1/widgets/counter.dart';
import 'package:flutter/material.dart';

class EnterValueClass extends StatelessWidget {
  const EnterValueClass(
      {super.key,
      required this.color,
      // required this.onchanged,
      required this.text,
      required this.textEditingController,
      required this.callback});

  final Color color;
  // final void Function(int) onchanged;
  final String text;
  final TextEditingController textEditingController;
  final ValueSetter<int> callback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 450,
        height: 30,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Image.asset("lib/assets/images/d20.png"),
            ),
            Expanded(child: Text(text)),
            Expanded(
              child: CustomCounter(
                callback: callback,
              ),
            )
          ],
        ),
      ),
    );
  }
}
