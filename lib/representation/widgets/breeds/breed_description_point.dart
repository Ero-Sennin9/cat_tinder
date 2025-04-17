import 'package:flutter/material.dart';

class BreedDescriptionPoint extends StatelessWidget {
  final String title;
  final String info;
  final double titleSize;
  final double infoSize;

  const BreedDescriptionPoint({
    required this.title,
    required this.info,
    required this.titleSize,
    required this.infoSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          info,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: infoSize),
        ),
      ],
    );
  }
}
