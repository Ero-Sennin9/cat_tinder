import 'package:flutter/material.dart';
import '../models/cat_manager.dart';
import '../models/cat.dart';
import 'likes_scope.dart';
import 'verdict_button.dart';
import 'likes_counter.dart';
import 'cat_cards_stack.dart';

class CatTinder extends StatefulWidget {
  const CatTinder({super.key});

  @override
  State<CatTinder> createState() => _CatTinderState();
}

class _CatTinderState extends State<CatTinder> {
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

  void _like() {
    setState(() {
      ++_likes;
    });
  }

  void _dislikeAction() {
    _updateCat();
  }

  void _likeAction() {
    _updateCat();
    _like();
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
              padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: VerdictButton(
                    verdict: Verdict.dislike,
                    callback: _dislikeAction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
