import 'package:injectable/injectable.dart';

import '../entities/cat.dart';
import '../entities/disliked_cat.dart';
import '../repositories/i_disliked_cats_repository.dart';

@injectable
class DislikeCatUseCase {
  final IDislikedCatsRepository _dislikedCatsRepository;

  DislikeCatUseCase(this._dislikedCatsRepository);

  Future<void> execute(Cat cat) {
    final dislikedCat = DislikedCat(cat: cat, dislikeTime: DateTime.now());
    return _dislikedCatsRepository.add(dislikedCat);
  }
}
