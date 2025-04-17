import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../widgets/cat_tinder.dart';
import '../widgets/cat_description.dart';

abstract class RouteNames {
  static const home = '/';
  static const catDescription = '/cat_description';
}

class NavigationManager {
  static final instance = NavigationManager();
  final key = GlobalKey<NavigatorState>();

  NavigatorState get navigator => key.currentState!;

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const CatTinder(),
          settings: settings,
        );
      case RouteNames.catDescription:
        return MaterialPageRoute(
          builder: (_) {
            final cat = settings.arguments as Cat;
            return CatDescription(cat: cat);
          },
          settings: settings,
        );
    }
    return null;
  }
}
