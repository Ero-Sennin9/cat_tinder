import 'package:cat_tinder/domain/entities/breed.dart';

import '../dto/cat.dart' as dto;
import '../../domain/entities/cat.dart' as entities;
import 'breed.dart' as breed;

dto.Cat toObjectBoxEntity(entities.Cat cat) {
  return dto.Cat(
    imageUrl: cat.imageUrl.toString(),
  )..breed.target = breed.toObjectBoxEntity(cat.breed);
}

entities.Cat toEntity(dto.Cat cat) {
  return entities.Cat(
    breed: breed.toEntity(cat.breed.target!),
    imageUrl: Uri.parse(cat.imageUrl),
  );
}

