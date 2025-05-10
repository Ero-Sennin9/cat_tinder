import '../../../domain/entities/disliked_cat.dart';

abstract class DislikedCatsEvent {}

class DeleteDislikedCat extends DislikedCatsEvent {
  final DislikedCat dislikedCatToDelete;
  DeleteDislikedCat(this.dislikedCatToDelete);
}

class DislikeAction extends DislikedCatsEvent {}

class UpdateAction extends DislikedCatsEvent {}
