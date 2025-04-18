import 'package:flutter/material.dart';

import '../../navigation/navigation_manager.dart';

class CatAlert extends StatelessWidget {
  const CatAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Критическая ошибка"),
      content: Text(
        "Произошли некоторый неполадки при загрузке данного кота. Мы очень сожалеем о том, что данная проблема настигла нашего многоуважаемого пользователя... Мы уже работаем над решением этой проблемы😔",
      ),
      actions: [
        TextButton(
          child: Text("Ну блииин("),
          onPressed: () {
            NavigationManager.instance.navigator.pop();
          },
        ),
      ],
    );
  }
}
