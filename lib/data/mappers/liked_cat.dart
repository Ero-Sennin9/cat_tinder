import '../dto/liked_cat.dart' as dto;
import '../../domain/entities/liked_cat.dart' as entities;

import 'cat.dart' as cat;

dto.LikedCat toObjectBoxEntity(entities.LikedCat likedCat) {
  return dto.LikedCat(likeTime: likedCat.likeTime)
    ..cat.target = cat.toObjectBoxEntity(likedCat.cat);
}

entities.LikedCat toEntity(dto.LikedCat likedCat) {
  return entities.LikedCat(
    cat: cat.toEntity(likedCat.cat.target!),
    likeTime: likedCat.likeTime,
  );
}
