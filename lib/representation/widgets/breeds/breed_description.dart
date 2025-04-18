import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import 'breed_description_point.dart';

class BreedDescription extends StatelessWidget {
  final Breed breed;

  static const error = BreedDescription(
    breed: Breed(
      id: "error",
      name: "Error while during loading breed",
      description: "Error while during loading description",
      temperament: "Error while during loading temperament",
      origin: "Error while during loading origin",
    ),
  );

  const BreedDescription({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BreedDescriptionPoint(
          title: breed.name,
          info: breed.description,
          titleSize: 25,
          infoSize: 18,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: BreedDescriptionPoint(
            title: "Temperament",
            info: breed.temperament,
            titleSize: 22,
            infoSize: 18,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: BreedDescriptionPoint(
            title: "Origin",
            info: breed.origin,
            titleSize: 22,
            infoSize: 18,
          ),
        ),
      ],
    );
  }
}
