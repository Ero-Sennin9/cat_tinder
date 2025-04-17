import 'package:cat_tinder/domain/repositories/i_liked_cats_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/liked_cat.dart';

@Singleton(as: ILikedCatsRepository)
class LikedCatsRepository implements ILikedCatsRepository {
  final List<LikedCat> _likedCats = [];

  void add(LikedCat likedCat) {
    _likedCats.add(likedCat);
  }

  bool delete(LikedCat likedCat) {
    return _likedCats.remove(likedCat);
  }

  Future<List<LikedCat>> getAll() async {
    return _likedCats;
  }
}
