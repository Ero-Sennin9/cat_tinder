import '../entities/cat.dart';
import '../entities/breed.dart';

abstract class IBreedsRepository {
  Future<Breed?> getByCat(Cat cat);
  Future<List<Breed>> getAll();
}