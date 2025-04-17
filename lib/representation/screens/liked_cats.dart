import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';
import '../../domain/entities/liked_cat.dart';
import '../bloc/liked_cats_bloc/bloc.dart';
import '../bloc/liked_cats_bloc/events.dart';
import '../bloc/liked_cats_bloc/states.dart';
import '../widgets/cats/liked_cat_item.dart';

class LikedCats extends StatefulWidget {
  const LikedCats({super.key});

  @override
  State<LikedCats> createState() => _LikedCatsState();
}

class _LikedCatsState extends State<LikedCats> {
  static const _spacing = 5.0;

  @override
  Widget build(BuildContext context) {
    // final List<LikedCat> likedCats = [];
    // for (final breedGroup in CatManager.instance
    //     .getLikedCats()
    //     .entries) {
    //   likedCats.addAll(breedGroup.value);
    // }

    return BlocBuilder<LikedCatsBloc, LikedCatsState>(
      builder: (context, state) {
        if (state is LikedCatsReady) {
          return Scaffold(
            appBar: null,
            body: ListView(
              children:
                  state.likedCats.map((LikedCat likedCat) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        _spacing,
                        0,
                        _spacing,
                        _spacing,
                      ),
                      child: LikedCatItem(
                        likedCat: likedCat,
                        cancelAction: () {
                          getIt<LikedCatsBloc>().add(DeleteLikedCat(likedCat));
                        },
                      ),
                    );
                  }).toList(),
            ),
          );
        }
        return Placeholder();
      },
    );
  }
}
