import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/cat.dart';
import '../../../domain/usecases/get_cat_use_case.dart';
import '../../../domain/usecases/like_cat_use_case.dart';
import 'events.dart';

@singleton
class SwipeableCatsBloc extends Bloc<SwipeableCatsEvent, SwipeableCatsState> {
  final GetCatUseCase _getCatUseCase;
  final LikeCatUseCase _likeCatUseCase;
  final List<Future<Cat>> cats = [];
  static const catsCount = 10;

  SwipeableCatsBloc(this._getCatUseCase, this._likeCatUseCase)
    : super(SwipeableCatsInitial()) {
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
      _likeCatUseCase.execute(cat);
    });
    _updateCats();
    emit(SwipeableCatsReady(cats));
  }

  void _dislikeActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    _updateCats();
    emit(SwipeableCatsReady(cats));
  }
}
