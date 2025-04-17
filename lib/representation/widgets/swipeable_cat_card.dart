import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import 'cat_card.dart';
import 'dart:math';

class SwipeableCatCard extends StatefulWidget {
  final Cat? cat;
  final Function() callbackLeft;
  final Function() callbackRight;

  const SwipeableCatCard({
    required this.cat,
    required this.callbackLeft,
    required this.callbackRight,
    super.key,
  });

  @override
  State<SwipeableCatCard> createState() => _CardState();
}

class _CardState extends State<SwipeableCatCard> {
  static const _responseDeviation = 20;
  static const _maxAngle = pi / 4;
  static const _cardSpeed = 0.4;

  double _angle = 0;
  double _positionX = 0;
  double _positionY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          final width = MediaQuery.of(context).size.width;
          _positionX += details.delta.dx * _cardSpeed;
          _positionY += details.delta.dy * _cardSpeed;
          _angle = _positionX / width * _maxAngle;
        });
      },
      onPanEnd: (DragEndDetails details) {
        setState(() {
          if (_positionX > _responseDeviation && widget.cat != null) {
            widget.callbackRight();
          } else if (_positionX < -_responseDeviation && widget.cat != null) {
            widget.callbackLeft();
          } else {
            _positionX = 0;
            _positionY = 0;
            _angle = 0;
          }
        });
      },
      child: Transform.rotate(
        alignment: Alignment.topCenter,
        angle: -_angle,
        child: Transform.translate(
          offset: Offset(_positionX, _positionY),
          child: CatCard(cat: widget.cat, action: (){}),
        ),
      ),
    );
  }
}
