class Breed {
  final String name;
  final String description;
  final String temperament;
  final String origin;
  static const error = Breed(
    name: "Error cat",
    description: "Totally mysterious cat...",
    temperament: "Who knows...",
    origin: "Unkown country...",
  );

  const Breed({
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
  });
}
