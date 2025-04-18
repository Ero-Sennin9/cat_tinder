import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/injection.dart';
import '../bloc/liked_cats_bloc/bloc.dart';
import '../screens/main_screen.dart';
import '../screens/liked_cats.dart';

class CatTinder extends StatefulWidget {
  const CatTinder({super.key});

  @override
  State<CatTinder> createState() => _CatTinderState();
}

class _CatTinderState extends State<CatTinder> {
  int currentTabIndex = 0;
  static const _likedCatsPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikedCatsBloc>(
      create: (_) => getIt<LikedCatsBloc>(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blue),
              label: "main screens",
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
            MainScreen(),
            Padding(
              padding: EdgeInsets.only(top: _likedCatsPadding),
              child: LikedCats(),
            ),
          ],
        ),
      ),
    );
  }
}
