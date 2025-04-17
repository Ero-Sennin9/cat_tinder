import 'package:injectable/injectable.dart';

import '../entities/liked_cat.dart';
import '../repositories/i_liked_cats_repository.dart';

@injectable
class DislikeCatUseCase {
  final ILikedCatsRepository _likedCatsRepository;

  DislikeCatUseCase(this._likedCatsRepository);

  void execute(LikedCat likedCat) {
    _likedCatsRepository.delete(likedCat);
  }
}