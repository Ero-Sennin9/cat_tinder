import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'liked_cats.dart';

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        items: [
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
          setState((){
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
    );
  }
}
