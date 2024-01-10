import 'package:flutter/material.dart';

class EnterValueClass extends StatelessWidget {
  const EnterValueClass(
      {super.key,
      required this.color,
      required this.onchanged,
      required this.text,
      required this.textEditingController});

  final Color color;
  final void Function(String) onchanged;
  final String text;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Image.asset("lib/assets/images/d20.png"),
          ),
          Text(text),
          const SizedBox(width: 80),
          SizedBox(
            width: 30,
            child: TextField(
              // decoration: InputDecoration(
              //   focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(width: 3, color: color),
              //   ),
              // ),

              keyboardType: TextInputType.number,
              controller: textEditingController,
              // validator: (value) {
              //   if (value == null ||
              //       value.isEmpty ||
              //       int.tryParse(value) == null ||
              //       int.tryParse(value)! <= 0) {
              //     return "must be valid,positive number";
              //   }
              //   return null;
              // },
              onSubmitted: onchanged,
            ),
          ),
        ],
      ),
    );
  }
}
