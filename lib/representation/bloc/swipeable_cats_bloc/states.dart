import '../../../domain/entities/cat.dart';

abstract class SwipeableCatsState {}

class SwipeableCatsInitial extends SwipeableCatsState {}

class SwipeableCatsReady extends SwipeableCatsState {
  final List<Future<Cat>> cats;
  SwipeableCatsReady(this.cats);
}
