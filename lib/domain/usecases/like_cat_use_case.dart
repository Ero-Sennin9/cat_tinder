import 'package:injectable/injectable.dart';

import '../repositories/i_liked_cats_repository.dart';
import '../entities/cat.dart';
import '../entities/liked_cat.dart';

@injectable
class LikeCatUseCase {
  final ILikedCatsRepository _likedCatsRepository;

  LikeCatUseCase(this._likedCatsRepository);

  Future<void> execute(Cat cat) {
    final likedCat = LikedCat(cat: cat, likeTime: DateTime.now());
    return _likedCatsRepository.add(likedCat);
  }
}
