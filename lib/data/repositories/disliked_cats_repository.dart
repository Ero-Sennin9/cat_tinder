import 'package:cat_tinder/domain/repositories/i_disliked_cats_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/disliked_cat.dart' as entities;
import '../../data/dto/disliked_cat.dart' as dto;
import '../mappers/disliked_cat.dart' as disliked_cat;
import '../object_box/objectbox.g.dart';

@Singleton(as: IDislikedCatsRepository)
class DislikedCatsRepository implements IDislikedCatsRepository {
  late final Box _objectBox;

  DislikedCatsRepository(@Named('disliked_cats_store') Store store) {
    _objectBox = store.box<dto.DislikedCat>();
  }

  @override
  Future<void> add(entities.DislikedCat dislikedCat) {
    return _objectBox.putAsync(disliked_cat.toObjectBoxEntity(dislikedCat));
  }

  @override
  Future<bool> delete(entities.DislikedCat dislikedCat) async {
    final query =
        _objectBox
            .query(
              DislikedCat_.dislikeTime.equals(
                dislikedCat.dislikeTime.millisecond,
              ),
            )
            .build();
    final countDeleted = query.remove();
    if (countDeleted > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<List<entities.DislikedCat>> getAll() async {
    final dislikedCats = _objectBox.getAll();
    return dislikedCats
        .map((dislikedCat) => disliked_cat.toEntity(dislikedCat))
        .toList();
  }

  @override
  Future<int> getAllCount() {
    return Future<int>.value(_objectBox.count());
  }
}
