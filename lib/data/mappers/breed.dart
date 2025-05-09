import '../dto/breed.dart' as dto;
import '../../domain/entities/breed.dart' as entities;

dto.Breed toObjectBoxEntity(entities.Breed breed) {
  return dto.Breed(
    id: breed.id,
    name: breed.name,
    description: breed.description,
    temperament: breed.temperament,
    origin: breed.origin,
  );
}

entities.Breed toEntity(dto.Breed breed) {
  return entities.Breed(
    id: breed.id,
    name: breed.name,
    description: breed.description,
    temperament: breed.temperament,
    origin: breed.origin,
  );
}
