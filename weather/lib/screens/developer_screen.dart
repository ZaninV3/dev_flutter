import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('О разработчике')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ФИО: Занин Вячеслав Александрович', style: TextStyle(fontSize: 18)),
            Text('Группа: ВМК-22', style: TextStyle(fontSize: 18)),
            Text('Контакты: zan1234098@gmail.com', style: TextStyle(fontSize: 18))
          ]
        )
      )
    );
  }
}
