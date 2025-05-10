import '../../../domain/entities/disliked_cat.dart';

abstract class DislikedCatsState {}

class DislikedCatsInitial extends DislikedCatsState {}

class DislikedCatsLoading extends DislikedCatsState {}

class DislikedCatsReady extends DislikedCatsState {
  final List<DislikedCat> dislikedCats;
  DislikedCatsReady(this.dislikedCats);
}
