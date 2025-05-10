import 'package:cat_tinder/domain/usecases/get_liked_cats_quantity_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'events.dart';
import 'states.dart';

@singleton
class LikedCatsCountBloc
    extends Bloc<LikedCatsCountEvent, LikedCatsCountState> {
  final GetLikedCatsQuantityUseCase _getLikedCatsQuantityUseCase;

  LikedCatsCountBloc(this._getLikedCatsQuantityUseCase)
    : super(LikedCatsCountInitial()) {
    on<UpdateAction>(_updateActionHandler);
    on<LikeAction>(_updateActionHandler);
    add(UpdateAction());
  }

  void _updateActionHandler(
    LikedCatsCountEvent event,
    Emitter<LikedCatsCountState> emit,
  ) {
    _getLikedCatsQuantityUseCase.execute().then((likedCatsCount) {
      emit(LikedCatsCountReady(likedCatsCount));
    });
  }
}
