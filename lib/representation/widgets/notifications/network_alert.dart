import 'package:flutter/material.dart';

class NetworkAlert extends StatelessWidget {
  const NetworkAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Сеть недоступна("),
      content: Text(
        "Приложение не может связаться с сетью. Проверьте подключение к интернету и перезапустите приложение...",
      ),
      actions: [],
    );
  }
}
