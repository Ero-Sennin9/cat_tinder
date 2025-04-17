import 'package:flutter/material.dart';

class DismissCatButton extends StatelessWidget {
  final Function() action;
  final double size;

  const DismissCatButton({required this.action, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      icon: Icon(Icons.cancel, size: size, color: Colors.red),
    );
  }
}
