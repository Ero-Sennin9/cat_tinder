import 'package:cat_tinder/domain/usecases/delete_liked_cat_use_case.dart';
import 'package:cat_tinder/domain/usecases/get_liked_cats_use_case.dart';
import 'package:cat_tinder/representation/bloc/liked_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'events.dart';

@singleton
class LikedCatsBloc extends Bloc<LikedCatsEvent, LikedCatsState> {
  final GetLikedCatsUseCase _getLikedCatsUseCase;
  final DeleteLikedCatUseCase _deleteLikedCatUseCase;

  LikedCatsBloc(this._getLikedCatsUseCase, this._deleteLikedCatUseCase)
    : super(LikedCatsInitial()) {
    on<DeleteLikedCat>(_deleteLikedCatHandler);
    on<LikeAction>(_updateActionHandler);
    on<UpdateAction>(_updateActionHandler);

    add(UpdateAction());
  }

  void _deleteLikedCatHandler(
    DeleteLikedCat event,
    Emitter<LikedCatsState> emit,
  ) {
    _deleteLikedCatUseCase.execute(event.likedCatToDelete).then((_) {
      add(UpdateAction());
    });
  }

  void _updateActionHandler(
    LikedCatsEvent event,
    Emitter<LikedCatsState> emit,
  ) {
    _getLikedCatsUseCase.execute().then((likedCats) {
      emit(LikedCatsReady(likedCats));
    });
  }
}
