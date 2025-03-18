import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function() action;

  const CustomBackButton({required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(150),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: action,
        icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
      ),
    );
  }
}
