import 'package:objectbox/objectbox.dart';

@Entity()
class Breed {
  @Id()
  int objectBoxId = 0;

  final String id;
  final String name;
  final String description;
  final String temperament;
  final String origin;
  Breed({
    required this.id,
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
  });
}
