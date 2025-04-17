import 'package:flutter/material.dart';
import '../../../di/injection.dart';
import '../../../domain/entities/breed.dart';
import '../../../domain/entities/cat.dart';
import 'cat_image.dart';

class CatCard extends StatelessWidget {
  final Future<Cat> catFuture;
  final Function() action;
  static const _roundRadius = 15.0;

  const CatCard({required this.catFuture, required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_roundRadius),
      ),
      child: GestureDetector(
        onTap: action,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_roundRadius),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: FutureBuilder(
                    future: catFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return CatImage(cat: Cat.error);
                      }
                      if (!snapshot.hasData) {
                        return SizedBox(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        );
                      }
                      return CatImage(cat: snapshot.data!);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: FutureBuilder(
                      future: catFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            Breed.error.name,
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Text(
                          snapshot.data!.breed.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        );
                      },
                    ),
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
