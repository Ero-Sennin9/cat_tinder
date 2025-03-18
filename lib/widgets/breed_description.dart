import 'package:flutter/material.dart';
import '../models/breed.dart';

class BreedDescription extends StatelessWidget {
  final Breed breed;
  const BreedDescription({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            breed.name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Text(breed.description, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
