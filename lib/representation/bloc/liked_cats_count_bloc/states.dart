abstract class LikedCatsCountState {}

class LikedCatsCountInitial extends LikedCatsCountState {}

class LikedCatsCountLoading extends LikedCatsCountState {}

class LikedCatsCountReady extends LikedCatsCountState {
  final int likedCatsCount;
  LikedCatsCountReady(this.likedCatsCount);
}
