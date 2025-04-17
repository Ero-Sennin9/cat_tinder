import 'package:flutter/material.dart';
import 'likes_scope.dart';

class LikesCounter extends StatelessWidget {
  const LikesCounter({super.key});

  String _getLikes(BuildContext context) {
    final likesScope = LikesScope.of(context);
    return likesScope.likes.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Вам понравилось ${_getLikes(context)} котиков😻!",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
