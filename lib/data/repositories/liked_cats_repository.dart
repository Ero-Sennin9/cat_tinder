import 'package:cat_tinder/domain/repositories/i_liked_cats_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/liked_cat.dart' as entities;
import '../../data/dto/liked_cat.dart' as dto;
import '../mappers/liked_cat.dart' as liked_cat;
import '../object_box/objectbox.g.dart';

@Singleton(as: ILikedCatsRepository)
class LikedCatsRepository implements ILikedCatsRepository {
  late final Box _objectBox;
  late final Future<void> catsInitialized;
  List<entities.LikedCat> bufferedCats = [];

  LikedCatsRepository(@Named('liked_cats_store') Store store) {
    _objectBox = store.box<dto.LikedCat>();
    catsInitialized = _getObjectBoxAll().then((dislikedCats) {
      bufferedCats = dislikedCats;
    });
  }

  @override
  Future<void> add(entities.LikedCat likedCat) async {
    await catsInitialized;
    bufferedCats.add(likedCat);

    await _objectBox.putAsync(liked_cat.toObjectBoxEntity(likedCat));
  }

  @override
  Future<bool> delete(entities.LikedCat likedCat) async {
    await catsInitialized;
    bufferedCats.removeWhere((bufferedCat) => bufferedCat == likedCat);

    final query =
        _objectBox
            .query(LikedCat_.likeTime.equalsDate(likedCat.likeTime))
            .build();
    final countDeleted = await query.removeAsync();
    if (countDeleted > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<entities.LikedCat>> getAll() async {
    await catsInitialized;
    return bufferedCats;
  }

  Future<List<entities.LikedCat>> _getObjectBoxAll() async {
    final likedCats = _objectBox.getAll();
    return likedCats.map((likedCat) => liked_cat.toEntity(likedCat)).toList();
  }

  @override
  Future<int> getAllCount() {
    return Future<int>.value(_objectBox.count());
  }
}
