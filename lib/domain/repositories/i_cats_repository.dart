import '../entities/cat.dart';

abstract class ICatsRepository {
  Future<Cat> get();
}