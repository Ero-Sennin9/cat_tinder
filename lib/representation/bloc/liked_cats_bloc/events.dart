import '../../../domain/entities/liked_cat.dart';

abstract class LikedCatsEvent {}

class DeleteLikedCat extends LikedCatsEvent {
  final LikedCat likedCatToDelete;
  DeleteLikedCat(this.likedCatToDelete);
}

class LikeAction extends LikedCatsEvent {}

class UpdateAction extends LikedCatsEvent {}
