import 'package:cat_tinder/domain/usecases/get_cat_use_case.dart';

import '../../../di/injection.dart';
import '../../../domain/entities/cat.dart';

abstract class SwipeableCatsState {}

class SwipeableCatsInitial extends SwipeableCatsState {}

class SwipeableCatsReady extends SwipeableCatsState {
  final List<Future<Cat>> cats = [];
  late final GetCatUseCase getCatUseCase;
  static const _catsCount = 10;

  SwipeableCatsOrdinary() {
    getCatUseCase = getIt<GetCatUseCase>();
    _initCats();
  }

  void _initCats() {
    for (var ind = 0; ind < _catsCount; ++ind) {
      cats.add(getCatUseCase.execute());
    }
  }

  void update() {
    cats.removeAt(0);
    cats.add(getCatUseCase.execute());
  }
}
