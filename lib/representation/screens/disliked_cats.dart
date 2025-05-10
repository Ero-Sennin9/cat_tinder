import 'package:cat_tinder/representation/widgets/breeds/breed_drop_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';
import '../../domain/entities/disliked_cat.dart';
import '../bloc/disliked_cats_bloc/bloc.dart';
import '../bloc/disliked_cats_bloc/events.dart';
import '../bloc/disliked_cats_bloc/states.dart';
import '../widgets/cats/disliked_cat_item.dart';

class DislikedCats extends StatefulWidget {
  const DislikedCats({super.key});

  @override
  State<DislikedCats> createState() => _DislikedCatsState();
}

class _DislikedCatsState extends State<DislikedCats> {
  String? breedFilter;
  static const _spacing = 5.0;
  List<DislikedCat> _filteredCats = [];

  List<String> _getBreeds(List<DislikedCat> dislikedCats) {
    final Set<String> breeds = {};
    for (final dislikedCat in dislikedCats) {
      breeds.add(dislikedCat.cat.breed.name);
    }
    return breeds.toList()..sort();
  }

  List<DislikedCat> _getFilterCats(List<DislikedCat> dislikedCats) {
    final List<DislikedCat> filteredCats = [];
    for (final dislikedCat in dislikedCats) {
      if (breedFilter == null || dislikedCat.cat.breed.name == breedFilter) {
        filteredCats.add(dislikedCat);
      }
    }
    return filteredCats;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DislikedCatsBloc, DislikedCatsState>(
      builder: (context, state) {
        if (state is DislikedCatsReady) {
          _filteredCats = _getFilterCats(state.dislikedCats);
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text("Disliked Cats"),
              actions: [
                CustomDropButton(
                  currentBreed: breedFilter,
                  breeds: _getBreeds(state.dislikedCats),
                  callback: (String? currentBreed) {
                    setState(() {
                      breedFilter = currentBreed;
                    });
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: _filteredCats.length,
              cacheExtent: MediaQuery.of(context).size.height * 10,
              itemBuilder: (context, index) {
                final dislikedCat = _filteredCats[index];
                return Padding(
                  key: ObjectKey(dislikedCat),
                  padding: EdgeInsets.fromLTRB(_spacing, 0, _spacing, _spacing),
                  child: DislikedCatItem(
                    key: ValueKey(dislikedCat),
                    dislikedCat: dislikedCat,
                    cancelAction: () {
                      breedFilter = null;
                      getIt<DislikedCatsBloc>().add(
                        DeleteDislikedCat(dislikedCat),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
        return Placeholder();
      },
    );
  }
}
