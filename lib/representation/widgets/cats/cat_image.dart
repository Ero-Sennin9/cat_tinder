import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../domain/entities/cat.dart';

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
          child: CachedNetworkImage(
            imageUrl: cat.imageUrl.toString(),
            placeholder:
                (context, url) => Image.asset("assets/images/loading_cat.png"),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}
