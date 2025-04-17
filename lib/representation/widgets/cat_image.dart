import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';

class CatImage extends StatelessWidget {
  final Cat cat;

  const CatImage({required this.cat, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: SizedBox(
        key: ValueKey(cat.imageUrl),
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 1,
          child: FadeInImage.assetNetwork(
            fadeInDuration: Duration(milliseconds: 300),
            placeholder: "assets/images/loading_cat.png",
            image: cat.imageUrl.toString(),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
