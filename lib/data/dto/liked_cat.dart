import '../../data/dto/cat.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LikedCat {
  @Id()
  int id = 0;

  final cat = ToOne<Cat>();
  final DateTime likeTime;

  LikedCat({required this.likeTime});
}
