import 'package:flutter/material.dart';
import '../models/cat.dart';
import '../models/cat_manager.dart';
import '../states/navigation_manager.dart';
import 'cat_image.dart';

class CatCard extends StatelessWidget {
  final Cat? cat;
  static const _roundRadius = 15.0;

  const CatCard({required this.cat, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_roundRadius),
      ),
      child: GestureDetector(
        onTap: () {
          if (cat != null) {
            NavigationManager.instance.navigator.pushNamed(
              RouteNames.catDescription,
              arguments: cat,
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_roundRadius),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cat != null) CatImage(cat: cat!),
                if (cat == null)
                  SizedBox(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    (cat != null)
                        ? CatManager.instance.breeds[cat!.breedID]!.name
                        : "Loading cat...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
