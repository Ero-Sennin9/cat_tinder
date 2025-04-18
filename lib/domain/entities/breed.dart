class Breed {
  final String id;
  final String name;
  final String description;
  final String temperament;
  final String origin;
  const Breed({
    required this.id,
    required this.name,
    required this.description,
    required this.temperament,
    required this.origin,
  });

  static const error = Breed(
    id: "error",
    name: "Error cat",
    description: "Totally mysterious cat...",
    temperament: "Who knows...",
    origin: "Unkown country...",
  );
}
