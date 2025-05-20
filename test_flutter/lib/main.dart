import 'package:flutter/material.dart';  // библиотека Flutter


void main() {  // Точка входа
  runApp(MyApp());  // Запуск приложения с виджетом MyApp как корневое
}


// Виджет MyApp. Основной виджет приложения (StatelessWidget - без состояния)
class MyApp extends StatelessWidget {
  @override  // Аннотация, показывающая переопределение метода
  Widget build(BuildContext context) {
    // Основа Material Design приложения
    return MaterialApp(
      // Scaffold - стандартная структура с AppBar и Body
      home: Scaffold(
        appBar: AppBar(  // Верхняя панель
          title: Text('Лабораторная работа')
        ),
        body: MainPage(),  // Основное поле
      )
    );
  }
}

// Выполнил Занин Вячеслав ВМК-22

// Виджет основного поля
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Можно пролистывать, если содержимое не помещается на экране
    return SingleChildScrollView(
      child: Column(  // Тот самый первый Column из задания
        children: [
          Row(  // Первый ряд изображений
            // Выравнивание
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // Контейнеры с картинками
            children: [
              _buildImageContainer('https://cdn.fishki.net/upload/post/201405/22/1271219/002.jpg'),
              _buildImageContainer('https://m.fishki.net/picsw/122010/02/bonus/sobaki/002.jpg'),
              _buildImageContainer('https://cs12.pikabu.ru/post_img/2021/08/31/8/1630411847138875200.jpg')
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImageContainer('https://cdn.fishki.net/upload/post/2017/07/18/2339755/12-11.jpg'),
              _buildImageContainer('https://cs14.pikabu.ru/post_img/2022/10/07/7/166513947915089827.jpg'),
              _buildImageContainer('https://trinixy.ru/pics4/20101130/funny_dogs_02.jpg')
            ],
          )
        ]
      )
    );
  }
}

// Метод для создания контейнера с картинками
// _ значит private
Widget _buildImageContainer(String image_url) {
  return Container(
    width: 400,
    child: Image.network(
      image_url,
      fit: BoxFit.fitWidth  // Заполнение всего контейнера с сжатием
    )
  );

}
