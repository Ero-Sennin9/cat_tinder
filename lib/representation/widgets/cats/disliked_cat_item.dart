import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/disliked_cat.dart';
import '../breeds/breed_description_point.dart';
import 'cat_image.dart';
import 'dismiss_cat_button.dart';
import '../../navigation/navigation_manager.dart';

class DislikedCatItem extends StatelessWidget {
  final DislikedCat dislikedCat;
  final Function() cancelAction;
  static const _width = 70.0;
  static const _spacing = 12.0;
  static const _roundRadius = 10.0;
  static const _titleSize = 20.0;
  static const _timeSize = 15.0;

  const DislikedCatItem({
    required this.dislikedCat,
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
                      arguments: dislikedCat.cat,
                    );
                  },
                  child: CatImage(cat: dislikedCat.cat),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BreedDescriptionPoint(
                  title: dislikedCat.cat.breed.name,
                  info: "",
                  titleSize: _titleSize,
                  infoSize: 0,
                ),

                Text(
                  DateFormat(
                    'yyyy-MM-dd HH:mm:ss',
                  ).format(dislikedCat.dislikeTime),
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
