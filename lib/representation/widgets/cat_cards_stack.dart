import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import 'swipeable_cat_card.dart';

class CatCardsStack extends StatelessWidget {
  static const _cardsIndent = 12.0;

  final Function() leftCallback;
  final Function() rightCallback;
  final List<Future<Cat>> cats;

  const CatCardsStack({
    required this.cats,
    required this.leftCallback,
    required this.rightCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: _cardsIndent * cats.length),
      child: Stack(
        alignment: Alignment.center,
        children:
            cats.asMap().entries.map((entry) {
              final catFuture = entry.value;
              final index = entry.key;
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: Transform.translate(
                  key: ObjectKey(catFuture),
                  offset: Offset(
                    (index != cats.length - 1)
                        ? (1 - 2 * (index % 2)) * _cardsIndent
                        : 0,
                    index * _cardsIndent,
                  ),
                  child: FutureBuilder<Cat>(
                    future: catFuture,
                    builder: (context, snapshot) {
                      return SwipeableCatCard(
                        cat: (snapshot.hasError) ? Cat.error : snapshot.data,
                        callbackLeft:
                            (index == cats.length - 1) ? leftCallback : () {},
                        callbackRight:
                            (index == cats.length - 1) ? rightCallback : () {},
                      );
                    },
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
