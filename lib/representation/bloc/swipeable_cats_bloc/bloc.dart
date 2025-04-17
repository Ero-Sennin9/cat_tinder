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
  final List<Future<Cat>> _cats = [];
  static const _catsCount = 10;

  SwipeableCatsBloc(this._getCatUseCase, this._likeCatUseCase)
    : super(SwipeableCatsInitial()) {
    initCats();
    emit(SwipeableCatsReady(_cats));
    on<LikeAction>(_likeActionHandler);
    on<DislikeAction>(_dislikeActionHandler);
  }

  void initCats() {
    for (var ind = 0; ind < _catsCount; ++ind) {
      _cats.add(_getCatUseCase.execute());
    }
  }

  void updateCats() {
    _cats.removeAt(0);
    _cats.add(_getCatUseCase.execute());
  }

  void _likeActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    _cats[0].then((cat) {
      _likeCatUseCase.execute(cat);
    });
    updateCats();
    emit(SwipeableCatsReady(_cats));
  }

  void _dislikeActionHandler(
    SwipeableCatsEvent event,
    Emitter<SwipeableCatsState> emit,
  ) {
    updateCats();
    emit(SwipeableCatsReady(_cats));
  }
}
