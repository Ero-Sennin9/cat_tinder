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

  LikedCatsBloc(this._getLikedCatsUseCase, this._deleteLikedCatUseCase) : super(LikedCatsInitial()) {
    _sendLikedCats();
    on<DeleteLikedCat>(_deleteLikedCatHandler);
  }
  void _deleteLikedCatHandler(DeleteLikedCat event, Emitter<LikedCatsState> emit) {
    _deleteLikedCatUseCase.execute(event.likedCatToDelete);
    _sendLikedCats();
  }
  void _sendLikedCats() {
    _getLikedCatsUseCase.execute().then((likedCats){
      emit(LikedCatsReady(likedCats));
    });
  }

}