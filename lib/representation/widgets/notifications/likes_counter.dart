import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/liked_cats_count_bloc/bloc.dart';
import '../../bloc/liked_cats_count_bloc/states.dart';

class LikesCounter extends StatelessWidget {
  const LikesCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedCatsCountBloc, LikedCatsCountState>(
      builder: (context, state) {
        if (state is! LikedCatsCountReady) {
          return const Center(child: CircularProgressIndicator());
        }
        return Text(
          key: ValueKey(state.likedCatsCount),
          "Вам понравилось ${state.likedCatsCount} котиков😻!",
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
