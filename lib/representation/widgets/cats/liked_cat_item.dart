import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/liked_cat.dart';
import '../breeds/breed_description_point.dart';
import 'cat_image.dart';
import 'dismiss_cat_button.dart';
import '../../navigation/navigation_manager.dart';

class LikedCatItem extends StatelessWidget {
  final LikedCat likedCat;
  final Function() cancelAction;
  static const _width = 70.0;
  static const _spacing = 12.0;
  static const _roundRadius = 10.0;
  static const _titleSize = 20.0;
  static const _timeSize = 15.0;

  const LikedCatItem({
    required this.likedCat,
    required this.cancelAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_roundRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_roundRadius),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(right: _spacing),
              child: SizedBox(
                width: _width,
                child: GestureDetector(
                  onTap: () {
                    NavigationManager.instance.navigator.pushNamed(
                      RouteNames.catDescription,
                      arguments: likedCat.cat,
                    );
                  },
                  child: CatImage(cat: likedCat.cat),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BreedDescriptionPoint(
                  title: likedCat.cat.breed.name,
                  info: "",
                  titleSize: _titleSize,
                  infoSize: 0,
                ),

                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(likedCat.likeTime),
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: _timeSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(0),
              child: DismissCatButton(action: cancelAction, size: _width / 2.0),
            ),
          ],
        ),
      ),
    );
  }
}
