import '../../data/dto/cat.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DislikedCat {
  @Id()
  int id = 0;

  final cat = ToOne<Cat>();
  final DateTime dislikeTime;

  DislikedCat({required this.dislikeTime});
}
