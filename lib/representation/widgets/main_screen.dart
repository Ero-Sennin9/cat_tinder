import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import 'likes_scope.dart';
import 'verdict_button.dart';
import 'likes_counter.dart';
import 'cat_cards_stack.dart';
import 'cat_alert.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const _cardsCount = 10;
  int _likes = 0;

  final List<Future<Cat>> _cats = List.generate(
    _cardsCount,
    (index) => CatManager.instance.getRandomCat(),
  );

  void _updateCat() {
    setState(() {
      _cats.removeLast();
      _cats.insert(0, CatManager.instance.getRandomCat());
    });
  }

  void _like(Cat cat) {
    setState(() {
      CatManager.instance.addLikedCat(cat);
      ++_likes;
    });
  }

  void _dislikeAction() {
    _updateCat();
  }

  void _likeAction() async {
    await _cats.last.timeout(Duration(microseconds: 1)).then((Cat cat) {
      _like(cat);
      _updateCat();
    }).catchError((error) {
      if (error is TimeoutException) {
        return;
      }
      showDialog(
        context: context,
        builder: (_) {
          return const CatAlert();
        }
      );
      _updateCat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LikesScope(
      likes: _likes,
      child: Scaffold(
        appBar: AppBar(title: Text('Cat Tinder'), centerTitle: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 20),
              child: CatCardsStack(
                cats: _cats,
                leftCallback: _dislikeAction,
                rightCallback: _likeAction,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: VerdictButton(
                    verdict: Verdict.dislike,
                    callback: _dislikeAction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: VerdictButton(
                    verdict: Verdict.like,
                    callback: _likeAction,
                  ),
                ),
              ],
            ),
            LikesCounter(),
          ],
        ),
      ),
    );
  }
}
