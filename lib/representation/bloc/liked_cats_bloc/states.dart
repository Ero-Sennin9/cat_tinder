import '../../../domain/entities/liked_cat.dart';

abstract class LikedCatsState {}

class LikedCatsInitial extends LikedCatsState {}

class LikedCatsLoading extends LikedCatsState {}

class LikedCatsReady extends LikedCatsState {
  final List<LikedCat> likedCats;
  LikedCatsReady(this.likedCats);
}
