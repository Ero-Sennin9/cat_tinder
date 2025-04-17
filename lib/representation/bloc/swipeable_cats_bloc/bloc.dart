import 'package:cat_tinder/representation/bloc/swipeable_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'events.dart';

@singleton
class SwipeableCatsBloc extends Bloc<SwipeableCatsEvent, SwipeableCatsState> {
  final _state = SwipeableCatsReady();

  SwipeableCatsBloc() : super(SwipeableCatsInitial()) {
    on<LikeAction>(_likeActionHandler);
  }

  void _likeActionHandler(SwipeableCatsEvent event, Emitter<SwipeableCatsState> emit) {
    _state.update();
    emit(_state);
  }
}