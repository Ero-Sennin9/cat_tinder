import 'package:injectable/injectable.dart';

import '../repositories/i_liked_cats_repository.dart';
import '../entities/liked_cat.dart';

@injectable
class DeleteLikedCatUseCase {
  final ILikedCatsRepository _likedCatsRepository;

  DeleteLikedCatUseCase(this._likedCatsRepository);
  void execute(LikedCat likedCat) {
    _likedCatsRepository.delete(likedCat);
  }
}
