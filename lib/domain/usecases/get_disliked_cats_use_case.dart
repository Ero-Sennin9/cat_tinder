import 'package:injectable/injectable.dart';

import '../repositories/i_disliked_cats_repository.dart';
import '../entities/disliked_cat.dart';

@injectable
class GetDislikedCatsUseCase {
  final IDislikedCatsRepository _dislikedCatsRepository;

  GetDislikedCatsUseCase(this._dislikedCatsRepository);

  Future<List<DislikedCat>> execute() {
    return _dislikedCatsRepository.getAll();
  }
}
