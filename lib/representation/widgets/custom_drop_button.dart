import 'package:flutter/material.dart';

class CustomDropButton extends StatelessWidget {
  final String value;
  final List<String> items;
  static const hintSize = 18.0;

  const CustomDropButton({required this.value, required this.items, key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      hint: Text(
          "Порода кота",
          style: TextStyle(
            fontSize: hintSize,
            color: Colors.amber,
          ),
      ),
      items: [

      ],
    );
  }
}
