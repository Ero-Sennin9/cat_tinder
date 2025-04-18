import 'package:flutter/material.dart';

class CustomDropButton extends StatelessWidget {
  final String? currentBreed;
  final List<String> breeds;
  final Function(String?) callback;
  static const textStyle = TextStyle(fontSize: 18, color: Colors.grey);

  const CustomDropButton({
    required this.currentBreed,
    required this.breeds,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentBreed,
      hint: Text("Порода кота", textAlign: TextAlign.left, style: textStyle),
      items:
          breeds.map((breedName) {
            return DropdownMenuItem<String>(
              value: breedName,
              child: Text(
                breedName,
                textAlign: TextAlign.left,
                style: textStyle,
              ),
            );
          }).toList(),
      onChanged: (String? newValue) {
        callback(newValue);
      },
    );
  }
}
