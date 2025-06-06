import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/audio_cubit.dart';

class ResultScreen extends StatelessWidget {
  // Параметры, передаваемые с предыдущего экрана, передаются через cubit
  
  // Конструктор
  const ResultScreen({super.key});

  // Выполнил Занин Вячеслав ВМК-22
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат расчета'),  // Заголовок экрана
      ),
      body: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          print('[DEBUG] Текущее состояние: $state');

          if (state is AudioLoading) {
            return Center(child: CircularProgressIndicator());


          } else if (state is AudioCalculated) {  // Всему свое время
          return Padding(
            padding: const EdgeInsets.all(16.0),  // Отступы от краев
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // Выравнивание по левому краю
              children: [
                // Отображение введенных параметров:
                Text('Тип файла: ${state.calcData['fileType'] == 1 ? "Моно" : "Стерео"}', style: TextStyle(fontSize: 18)),
                Text('Частота дискретизации: ${state.calcData['sampleRate']} Гц', style: TextStyle(fontSize: 18)),
                Text('Глубина кодирования: ${state.calcData['bitDepth']} бит', style: TextStyle(fontSize: 18)),
                Text('Длительность: ${state.calcData['duration']} секунд', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),  // Разделитель
                
                // Отображение результата:
                Text('Объем файла:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(state.formattedSize, style: TextStyle(fontSize: 24, color: Colors.blue)),
                SizedBox(height: 20),

                // Кнопка возврата
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);  // Закрываем текущий экран
                  },
                  child: Text('Назад')
                )
              ]
            )
          );
          // Обработка особых случаев
          } else if (state is AudioError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          } 
          
          return Center(child: Text('Данные не загружены'));
        }
      )
      /*
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Отступы от краев
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // Выравнивание по левому краю
          children: [
            // Отображение введенных параметров:
            Text('Тип файла: ${fileType == 1 ? "Моно" : "Стерео"}', style: TextStyle(fontSize: 18)),
            Text('Частота дискретизации: $sampleRate Гц', style: TextStyle(fontSize: 18)),
            Text('Глубина кодирования: $bitDepth бит', style: TextStyle(fontSize: 18)),
            Text('Длительность: $duration секунд', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),  // Разделитель
            
            // Отображение результата:
            Text('Объем файла:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(formattedSize, style: TextStyle(fontSize: 24, color: Colors.blue)),
            SizedBox(height: 20),
            
            // Кнопка возврата
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);  // Закрываем текущий экран
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
      */    
    );
  }
}
