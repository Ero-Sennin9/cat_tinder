import 'package:injectable/injectable.dart';

import '../repositories/i_liked_cats_repository.dart';
import '../entities/liked_cat.dart';

@injectable
class GetLikedCatsUseCase {
  final ILikedCatsRepository _likedCatsRepository;

  GetLikedCatsUseCase(this._likedCatsRepository);

  Future<List<LikedCat>> execute() {
    return _likedCatsRepository.getAll();
  }
}
