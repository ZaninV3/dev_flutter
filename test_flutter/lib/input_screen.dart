import 'package:flutter/material.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // Контроллеры для управления текстовыми полями:
  final TextEditingController _fileTypeController = TextEditingController();  // Для типа файла (1/2)
  final TextEditingController _sampleRateController = TextEditingController();  // Для частоты дискретизации
  final TextEditingController _bitDepthController = TextEditingController();  // Для глубины кодирования
  final TextEditingController _durationController = TextEditingController();  // Для длительности
  
  bool isAgreed = false;  // Состояние чекбокса согласия
  final _formKey = GlobalKey<FormState>();  // Ключ для управления состоянием формы

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расчет объема звукового файла'),  // Заголовок экрана
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Отступы от краев экрана
        child: Form(
          key: _formKey,  // Привязываем ключ формы
          child: ListView(  // Прокручиваемый список виджетов
            children: [
              // Поле ввода для типа файла
              TextFormField(
                controller: _fileTypeController,
                keyboardType: TextInputType.number,  // Цифровая клавиатура
                decoration: InputDecoration(
                  labelText: 'Тип файла (1-моно, 2-стерео)',
                  hintText: 'Введите 1 или 2',  // Подсказка внутри поля
                ),
                validator: (value) {
                  // Валидация введенного значения:
                  if (value == null || value.isEmpty) {
                    return 'Введите тип файла';  // Ошибка если пусто
                  }
                  final num = int.tryParse(value);
                  if (num == null || (num != 1 && num != 2)) {
                    return 'Только 1 (моно) или 2 (стерео)';  // Ошибка если не 1 или 2
                  }
                  return null;  // Валидация пройдена
                },
              ),
              
              // Поле ввода для частоты дискретизации
              TextFormField(
                controller: _sampleRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Частота дискретизации (Гц)',
                  hintText: 'Например: 44100',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите частоту дискретизации';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Введите целое число';
                  }
                  return null;
                },
              ),
              
              // Поле ввода для глубины кодирования
              TextFormField(
                controller: _bitDepthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Глубина кодирования (бит)',
                  hintText: 'Например: 16',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите глубину кодирования';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Введите целое число';
                  }
                  return null;
                },
              ),
              
              // Поле ввода для длительности
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Длительность (секунды)',
                  hintText: 'Например: 180.5',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите длительность';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите число';
                  }
                  return null;
                },
              ),
              
              // Чекбокс для согласия на обработку данных
              CheckboxListTile(
                title: Text('Я согласен на обработку данных'),
                value: isAgreed,
                onChanged: (bool? value) {
                  setState(() {  // Обновляем состояние при изменении
                    isAgreed = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  // Чекбокс слева от текста
              ),
              
              // Кнопка для расчета
              ElevatedButton(
                onPressed: () {
                  // Проверяем валидность формы и согласие
                  if (_formKey.currentState!.validate() && isAgreed) {
                    // Переход на экран результатов с передачей данных
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          fileType: int.parse(_fileTypeController.text),
                          sampleRate: int.parse(_sampleRateController.text),
                          bitDepth: int.parse(_bitDepthController.text),
                          duration: double.parse(_durationController.text),
                        ),
                      ),
                    );
                  } else if (!isAgreed) {
                    // Показываем сообщение об ошибке если нет согласия
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Необходимо согласие на обработку данных')),
                    );
                  }
                },
                child: Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
// Выполнил Занин Вячеслав ВМК-22

  @override
  void dispose() {
    // Очищаем контроллеры при уничтожении виджета
    _fileTypeController.dispose();
    _sampleRateController.dispose();
    _bitDepthController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}