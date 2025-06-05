import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/audio_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AudioCubit(),
      child: MyApp()  // Cubit доступен во всем приложении
    )
  );
}

// Выполнил Занин Вячеслав ВМК-22

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider.value(
        value: BlocProvider.of<AudioCubit>(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Занин Вячеслав Александрович')),
          body: InputScreen()
        )
      )
    );
    /*
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Занин Вячеслав Александрович')),
        body: InputScreen()
      ),
    );
    */
  }
}