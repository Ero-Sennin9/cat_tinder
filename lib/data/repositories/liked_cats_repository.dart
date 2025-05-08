import 'package:cat_tinder/domain/repositories/i_liked_cats_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../domain/entities/liked_cat.dart' as entities;
import '../../data/dto/liked_cat.dart' as dto;
import '../mappers/liked_cat.dart' as liked_cat;
import '../object_box/objectbox.g.dart';

@Singleton(as: ILikedCatsRepository)
class LikedCatsRepository implements ILikedCatsRepository {
  late final Box _objectBox;

  LikedCatsRepository(@Named('liked_cats_store') Store store) {
    _objectBox = store.box<dto.LikedCat>();
  }

  @override
  Future<void> add(entities.LikedCat likedCat) {
    return _objectBox.putAsync(liked_cat.toObjectBoxEntity(likedCat));

  }

  @override
  Future<bool> delete(entities.LikedCat likedCat) async {

    final query = _objectBox.query(
        LikedCat_.likeTime.equalsDate(likedCat.likeTime)).build();
    final countDeleted = await query.removeAsync();
    if (countDeleted > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<entities.LikedCat>> getAll() async {
    final likedCats = _objectBox.getAll();
    return likedCats.map((likedCat) => liked_cat.toEntity(likedCat)).toList();
  }
}
