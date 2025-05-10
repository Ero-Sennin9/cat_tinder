import 'package:injectable/injectable.dart';

import '../repositories/i_disliked_cats_repository.dart';
import '../entities/disliked_cat.dart';

@injectable
class DeleteDislikedCatUseCase {
  final IDislikedCatsRepository _dislikedCatsRepository;

  DeleteDislikedCatUseCase(this._dislikedCatsRepository);
  Future<void> execute(DislikedCat dislikedCat) {
    return _dislikedCatsRepository.delete(dislikedCat);
  }
}
