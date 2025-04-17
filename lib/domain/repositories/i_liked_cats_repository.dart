import '../entities/cat.dart';
import '../entities/liked_cat.dart';

abstract class ILikedCatsRepository {
  void add(LikedCat likedCat);
  bool delete(LikedCat likedCat);
  Future<List<LikedCat>> getAll();
}