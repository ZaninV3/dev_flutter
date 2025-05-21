import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  // Параметры, передаваемые с предыдущего экрана:
  final int fileType;  // 1 - моно, 2 - стерео
  final int sampleRate;  // частота дискретизации в Гц
  final int bitDepth;  // глубина кодирования в битах
  final double duration;  // длительность в секундах
  
  // Конструктор с обязательными параметрами
  const ResultScreen({super.key, 
    required this.fileType,
    required this.sampleRate,
    required this.bitDepth,
    required this.duration,
  });
  
  // Функция расчета объема файла в байтах
  double calculateFileSize() {
    // Формула расчета: (частота * глубина * каналы * время) / 8 бит в байте
    return (sampleRate * bitDepth * fileType * duration) / 8;
  }
  
  // Функция для форматирования размера файла
  String formatFileSize(double bytes) {
    if (bytes < 1024) {
      return '${bytes.toStringAsFixed(2)} байт';  // Меньше 1 КБ
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} КБ';  // Меньше 1 МБ
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} МБ';  // Меньше 1 ГБ
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} ГБ';  // Больше 1 ГБ
    }
  }

  // Выполнил Занин Вячеслав ВМК-22
  
  @override
  Widget build(BuildContext context) {
    // Вычисляем размер файла
    final fileSize = calculateFileSize();
    // Форматируем для отображения
    final formattedSize = formatFileSize(fileSize);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат расчета'),  // Заголовок экрана
      ),
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
    );
  }
}