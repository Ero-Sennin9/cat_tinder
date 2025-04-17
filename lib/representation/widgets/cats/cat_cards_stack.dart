import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/injection.dart';
import '../../../domain/entities/breed.dart';
import '../../../domain/entities/cat.dart';
import '../../bloc/swipeable_cats_bloc/bloc.dart';
import '../../bloc/swipeable_cats_bloc/events.dart';
import 'swipeable_cat_card.dart';

class CatCardsStack extends StatelessWidget {
  static const _cardsIndent = 12.0;

  const CatCardsStack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwipeableCatsBloc>(
      create: (_) => getIt<SwipeableCatsBloc>(),
      child: BlocBuilder<SwipeableCatsBloc, SwipeableCatsState>(
        builder: (context, state) {
          if (state is SwipeableCatsReady) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: _cardsIndent * state.cats.length,
              ),
              child: Stack(
                alignment: Alignment.center,
                children:
                    state.cats.asMap().entries.map((entry) {
                      final catFuture = entry.value;
                      final index = entry.key;
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        child: Transform.translate(
                          key: ObjectKey(catFuture),
                          offset: Offset(
                            (index != state.cats.length - 1)
                                ? (1 - 2 * (index % 2)) * _cardsIndent
                                : 0,
                            index * _cardsIndent,
                          ),
                          child: FutureBuilder<Cat>(
                            future: catFuture,
                            builder: (context, snapshot) {
                              return SwipeableCatCard(
                                catFuture: catFuture,
                                callbackLeft:
                                    (index == state.cats.length - 1)
                                        ? () {
                                          getIt<SwipeableCatsBloc>().add(
                                            DislikeAction(),
                                          );
                                        }
                                        : () {},
                                callbackRight:
                                    (index == state.cats.length - 1)
                                        ? () {
                                          getIt<SwipeableCatsBloc>().add(
                                            LikeAction(),
                                          );
                                        }
                                        : () {},
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
              ),
            );
          }
          return Placeholder();
        },
      ),
    );
  }
}
