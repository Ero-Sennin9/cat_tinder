import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';
import '../bloc/liked_cats_bloc/bloc.dart';
import '../bloc/disliked_cats_bloc/bloc.dart';
import '../screens/main_screen.dart';
import '../screens/liked_cats.dart';
import '../screens/disliked_cats.dart';

class CatTinder extends StatefulWidget {
  const CatTinder({super.key});

  @override
  State<CatTinder> createState() => _CatTinderState();
}

class _CatTinderState extends State<CatTinder> {
  int currentTabIndex = 1;
  static const _ratedCatsPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken, color: Colors.red),
            label: "disliked cats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: "main screen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.red),
            label: "liked cats",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentTabIndex,
        children: [
          BlocProvider<DislikedCatsBloc>(
            create: (_) => getIt<DislikedCatsBloc>(),
            child: Padding(
              padding: EdgeInsets.only(top: _ratedCatsPadding),
              child: DislikedCats(),
            ),
          ),
          MainScreen(),
          BlocProvider<LikedCatsBloc>(
            create: (_) => getIt<LikedCatsBloc>(),
            child: Padding(
              padding: EdgeInsets.only(top: _ratedCatsPadding),
              child: LikedCats(),
            ),
          ),
        ],
      ),
    );
  }
}
