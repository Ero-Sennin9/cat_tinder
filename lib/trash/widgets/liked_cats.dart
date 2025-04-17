import 'package:flutter/material.dart';
import '../models/cat_manager.dart';
import '../models/cat.dart';
import '../models/liked_cat.dart';
import 'liked_cat_item.dart';

class LikedCats extends StatefulWidget {
  const LikedCats({super.key});

  @override
  State<LikedCats> createState() => _LikedCatsState();
}

class _LikedCatsState extends State<LikedCats> {
  static const _spacing = 5.0;

  @override
  Widget build(BuildContext context) {
    final List<LikedCat> likedCats = [];
    for (final breedGroup in CatManager.instance.getLikedCats().entries) {
      likedCats.addAll(breedGroup.value);
    }

    return Scaffold(
      appBar: null,
      body: ListView(
        children:
        likedCats.map((LikedCat likedCat) {
              return Padding(
                padding: EdgeInsets.fromLTRB(_spacing, 0, _spacing, _spacing),
                child: LikedCatItem(likedCat: likedCat, cancelAction: () {
                  final breedID = likedCat.cat.breedID;
                  final breedName = CatManager.instance.breeds[breedID]!.name;
                  setState((){
                    CatManager.instance.getLikedCats()[breedName]!.remove(likedCat);
                  });
                }),
              );
            }).toList(),
      ),
    );
  }
}
