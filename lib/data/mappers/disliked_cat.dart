import '../dto/disliked_cat.dart' as dto;
import '../../domain/entities/disliked_cat.dart' as entities;

import 'cat.dart' as cat;

dto.DislikedCat toObjectBoxEntity(entities.DislikedCat dislikedCat) {
  return dto.DislikedCat(dislikeTime: dislikedCat.dislikeTime)
    ..cat.target = cat.toObjectBoxEntity(dislikedCat.cat);
}

entities.DislikedCat toEntity(dto.DislikedCat dislikedCat) {
  return entities.DislikedCat(
    cat: cat.toEntity(dislikedCat.cat.target!),
    dislikeTime: dislikedCat.dislikeTime,
  );
}
