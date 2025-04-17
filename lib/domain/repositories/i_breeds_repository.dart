import '../entities/cat.dart';
import '../entities/breed.dart';

abstract class IBreedsRepository {
  Future<List<Breed>> getAll();
}