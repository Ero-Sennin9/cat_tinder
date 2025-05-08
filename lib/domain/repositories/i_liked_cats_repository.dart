import '../entities/liked_cat.dart';

abstract class ILikedCatsRepository {
  Future<void> add(LikedCat likedCat);
  Future<bool> delete(LikedCat likedCat);
  Future<List<LikedCat>> getAll();
}
