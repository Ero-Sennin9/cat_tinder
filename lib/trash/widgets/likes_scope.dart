import 'package:flutter/material.dart';

class LikesScope extends InheritedWidget {
  final int likes;
  const LikesScope({required this.likes, required super.child, super.key});

  static LikesScope of(BuildContext context) {
    final LikesScope? result =
        context.dependOnInheritedWidgetOfExactType<LikesScope>();
    assert(result != null, 'No LikesScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LikesScope oldWidget) {
    return oldWidget.likes != likes;
  }
}
