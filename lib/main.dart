import 'package:cat_tinder/representation/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationManager.instance.key,
      title: 'Cat Tinder',
      onGenerateRoute: NavigationManager.onGenerateRoute,
      initialRoute: RouteNames.home,
    );
  }
}
