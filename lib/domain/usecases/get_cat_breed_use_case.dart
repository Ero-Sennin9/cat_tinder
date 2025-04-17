import 'package:injectable/injectable.dart';

import '../repositories/i_breeds_repository.dart';
import '../entities/breed.dart';
import '../entities/cat.dart';

@injectable
class GetCatBreedUseCase {
  final IBreedsRepository _breedsRepository;

  GetCatBreedUseCase(this._breedsRepository);

  Future<Breed?> execute(Cat cat) {
    return _breedsRepository.getByCat(cat);
  }
}