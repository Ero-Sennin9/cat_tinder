import '../entities/breed.dart';

abstract class IBreedsRepository {
  Future<List<Breed>> getAll();
}
