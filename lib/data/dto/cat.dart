import '../../data/dto/breed.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Cat {
  @Id()
  int id = 0;

  final String imageUrl;
  final breed = ToOne<Breed>();
  Cat({required this.imageUrl});
}
