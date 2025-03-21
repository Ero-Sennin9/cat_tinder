import 'package:flutter/material.dart';
import 'states/navigation_manager.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
