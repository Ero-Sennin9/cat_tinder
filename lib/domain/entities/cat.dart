import 'breed.dart';

class Cat {
  final Uri imageUrl;
  final Breed breed;
  const Cat({required this.imageUrl, required this.breed});

  static final error = Cat(
    imageUrl: Uri.parse(
      "https://c.wallhere.com/photos/1a/d7/sunset_silhouette_cat_profile_jinx_supershot-870891.jpg!d",
    ),
    breed: Breed.error,
  );
}
