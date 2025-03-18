class Breed {
  final String name;
  final String description;
  static const error = Breed(
    name: "Error cat",
    description: "Totally mysterious cat...",
  );

  const Breed({required this.name, required this.description});
}
