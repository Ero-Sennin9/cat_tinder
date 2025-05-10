import 'package:cat_tinder/domain/usecases/delete_disliked_cat_use_case.dart';
import 'package:cat_tinder/domain/usecases/get_disliked_cats_use_case.dart';
import 'package:cat_tinder/representation/bloc/disliked_cats_bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'events.dart';

@singleton
class DislikedCatsBloc extends Bloc<DislikedCatsEvent, DislikedCatsState> {
  final GetDislikedCatsUseCase _getDislikedCatsUseCase;
  final DeleteDislikedCatUseCase _deleteDislikedCatUseCase;

  DislikedCatsBloc(this._getDislikedCatsUseCase, this._deleteDislikedCatUseCase)
    : super(DislikedCatsInitial()) {
    on<DeleteDislikedCat>(_deleteDislikedCatHandler);
    on<DislikeAction>(_updateActionHandler);
    on<UpdateAction>(_updateActionHandler);

    add(UpdateAction());
  }

  void _deleteDislikedCatHandler(
    DeleteDislikedCat event,
    Emitter<DislikedCatsState> emit,
  ) {
    _deleteDislikedCatUseCase.execute(event.dislikedCatToDelete).then((_) {
      add(UpdateAction());
    });
  }

  void _updateActionHandler(
    DislikedCatsEvent event,
    Emitter<DislikedCatsState> emit,
  ) {
    _getDislikedCatsUseCase.execute().then((dislikedCats) {
      emit(DislikedCatsReady(dislikedCats));
    });
  }
}
