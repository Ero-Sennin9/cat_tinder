import 'package:cat_tinder/representation/bloc/liked_cats_bloc/bloc.dart';
import 'package:cat_tinder/representation/bloc/disliked_cats_bloc/bloc.dart';
import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/cat.dart';
import '../../../domain/usecases/get_cat_use_case.dart';
import '../../../domain/usecases/like_cat_use_case.dart';
import '../../../domain/usecases/dislike_cat_use_case.dart';
import '../liked_cats_bloc/events.dart' as liked_cats_bloc;
import '../disliked_cats_bloc/events.dart' as disliked_cats_bloc;
import '../liked_cats_count_bloc/events.dart' as liked_cats_count_bloc;
import '../liked_cats_count_bloc/bloc.dart';
import 'events.dart';

@singleton
class SwipeableCatsBloc extends Bloc<SwipeableCatsEvent, SwipeableCatsState> {
  final GetCatUseCase _getCatUseCase;
  final LikeCatUseCase _likeCatUseCase;
  final DislikeCatUseCase _dislikeCatUseCase;

  final LikedCatsBloc _likedCatsBloc;
  final LikedCatsCountBloc _likedCatsCountBloc;
  final DislikedCatsBloc _dislikedCatsBloc;

  final List<Future<Cat>> cats = [];
  static const catsCount = 10;

  SwipeableCatsBloc(
    this._likedCatsBloc,
    this._dislikedCatsBloc,
    this._likedCatsCountBloc,
    this._getCatUseCase,
    this._likeCatUseCase,
    this._dislikeCatUseCase,
  ) : super(SwipeableCatsInitial()) {
    on<LikeAction>(_likeActionHandler);
    on<DislikeAction>(_dislikeActionHandler);
    on<UpdateAction>(_updateActionHandler);

    _initCats();
    add(UpdateAction());
  }

  void _initCats() {
    for (var ind = 0; ind < catsCount; ++ind) {
      cats.add(_getCatUseCase.execute());
    }
  }

  void _updateCats() {
    cats.removeLast();
    cats.insert(0, _getCatUseCase.execute());
  }

  void _updateActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    emit(SwipeableCatsReady(cats));
  }

  void _likeActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    cats.last.then((cat) {
      _likeCatUseCase.execute(cat).then((_) {
        _likedCatsBloc.add(liked_cats_bloc.LikeAction());
        _likedCatsCountBloc.add(liked_cats_count_bloc.LikeAction());
      });
    });
    _updateCats();
    emit(SwipeableCatsReady(cats));
  }

  void _dislikeActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    cats.last.then((cat) {
      _dislikeCatUseCase.execute(cat).then((_) {
        _dislikedCatsBloc.add(disliked_cats_bloc.DislikeAction());
      });
    });
    _updateCats();
    emit(SwipeableCatsReady(cats));
  }
}
