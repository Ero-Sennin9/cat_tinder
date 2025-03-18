class Cat {
  final Uri imageUrl;
  final String breedID;
  const Cat({required this.imageUrl, required this.breedID});

  static final error = Cat(
    imageUrl: Uri.parse(
      "https://smartpress.by/upload/resize_cache/iblock/ced/10u0qxgzrutqnc0km37ccvmy365e6sgu/1200_630_1/black_and_white_cat_shadow_darkness_black_cat_monochrome_117775_pxhere.com-_1_.jpg",
    ),
    breedID: "error",
  );
}
