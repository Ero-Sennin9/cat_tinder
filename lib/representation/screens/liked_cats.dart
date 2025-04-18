import 'package:cat_tinder/representation/widgets/breeds/breed_drop_button.dart';
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
  String? breedFilter;
  static const _spacing = 5.0;

  List<String> _getBreeds(List<LikedCat> likedCats) {
    final Set<String> breeds = {};
    for (final likedCat in likedCats) {
      breeds.add(likedCat.cat.breed.name);
    }
    return breeds.toList()..sort();
  }

  List<LikedCat> _getFilterCats(List<LikedCat> likedCats) {
    final List<LikedCat> filteredLikedCats = [];
    for (final likedCat in likedCats) {
      if (breedFilter == null || likedCat.cat.breed.name == breedFilter) {
        filteredLikedCats.add(likedCat);
      }
    }
    return filteredLikedCats;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCatsBloc, LikedCatsState>(
      builder: (context, state) {
        if (state is LikedCatsReady) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text("Liked Cats"),
              actions: [
                CustomDropButton(
                  currentBreed: breedFilter,
                  breeds: _getBreeds(state.likedCats),
                  callback: (String? currentBreed) {
                    setState(() {
                      breedFilter = currentBreed;
                    });
                  },
                ),
              ],
            ),
            body: ListView(
              children:
                  _getFilterCats(state.likedCats).map((LikedCat likedCat) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        _spacing,
                        0,
                        _spacing,
                        _spacing,
                      ),
                      child: LikedCatItem(
                        key: ValueKey(likedCat),
                        likedCat: likedCat,
                        cancelAction: () {
                          breedFilter = null;
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
