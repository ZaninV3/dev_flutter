import 'package:flutter/material.dart';
import 'input_screen.dart';

void main() {
  runApp(MyApp());
}

// Выполнил Занин Вячеслав ВМК-22

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Занин Вячеслав Александрович'),
        ),
        body: InputScreen()
      )
    );
  }
}