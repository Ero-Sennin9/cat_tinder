import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/liked_cats_bloc/bloc.dart';
import '../../bloc/liked_cats_bloc/states.dart';

class LikesCounter extends StatelessWidget {
  const LikesCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCatsBloc, LikedCatsState>(
      builder: (context, state) {
        if (state is! LikedCatsReady) {
          return const Center(child: CircularProgressIndicator());
        }
        return Text(
          key: ValueKey(state.likedCats.length),
          "Вам понравилось ${state.likedCats.length} котиков😻!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        );
      },
    );
  }
}
