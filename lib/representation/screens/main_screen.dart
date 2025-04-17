import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../di/injection.dart';
import '../../domain/entities/cat.dart';
import '../bloc/swipeable_cats_bloc/events.dart';
import '../widgets/common/verdict_button.dart';
import '../widgets/notifications/likes_counter.dart';
import '../widgets/cats/cat_cards_stack.dart';
import '../widgets/notifications/cat_alert.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 30, 50, 20),
            child: CatCardsStack(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: VerdictButton(
                  verdict: Verdict.dislike,
                  callback: () {
                    getIt<SwipeableCatsBloc>().add(DislikeAction());
                    print("left button tapped");
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: VerdictButton(
                  verdict: Verdict.like,
                  callback: () {
                    getIt<SwipeableCatsBloc>().add(LikeAction());
                    print("right button tapped");
                  },
                ),
              ),
            ],
          ),
          LikesCounter(),
        ],
      ),
    );
  }
}
