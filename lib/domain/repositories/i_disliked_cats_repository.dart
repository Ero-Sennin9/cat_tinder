import '../entities/disliked_cat.dart';

abstract class IDislikedCatsRepository {
  Future<void> add(DislikedCat dislikedCat);
  Future<bool> delete(DislikedCat dislikedCat);
  Future<List<DislikedCat>> getAll();
}
