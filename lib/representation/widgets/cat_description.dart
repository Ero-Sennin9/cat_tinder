import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../../trash/states/navigation_manager.dart';
import 'cat_image.dart';
import 'custom_back_button.dart';
import 'breed_description.dart';

class CatDescription extends StatelessWidget {
  final Cat cat;

  const CatDescription({required this.cat, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatImage(cat: cat),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: BreedDescription(
                    breed: CatManager.instance.breeds[cat.breedID]!,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: AppBar(
              leading: CustomBackButton(
                action: () {
                  NavigationManager.instance.navigator.pop();
                },
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
