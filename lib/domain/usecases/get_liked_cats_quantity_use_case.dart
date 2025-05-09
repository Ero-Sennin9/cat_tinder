import 'package:injectable/injectable.dart';

import '../repositories/i_liked_cats_repository.dart';

@injectable
class GetLikedCatsQuantityUseCase {
  final ILikedCatsRepository _likedCatsRepository;

  GetLikedCatsQuantityUseCase(this._likedCatsRepository);

  Future<int> execute() {
    return _likedCatsRepository.getAllCount();
  }
}
