import 'package:injectable/injectable.dart';

import '../repositories/i_cats_repository.dart';
import '../entities/cat.dart';

@injectable
class GetCatUseCase {
  final ICatsRepository _catsRepository;

  GetCatUseCase(this._catsRepository);

  Future<Cat> execute() {
    return _catsRepository.get();
  }
}
