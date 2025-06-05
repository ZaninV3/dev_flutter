import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/audio_cubit.dart';

// Экран отображения истории
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Диалог подтверждения
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Очистить историю'),
                    content: const Text('Вы уверены?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отмена')
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AudioCubit>().clearHistory();
                          Navigator.pop(context);
                        },
                        child: const Text('Очистить', style: TextStyle(color: Colors.red))
                      )
                    ]
                  );
                }
              );
            }            
          )
        ]
      ),
      body: BlocBuilder<AudioCubit, AudioState>(  // Слушаем состояния Cubit
        builder: (context, state) {
          if (state is AudioHistory) {
            if (state.history.isEmpty) {
              return const Center(child: Text('Пока пусто'));
            }

            // Отображение расчетов
            return ListView.builder(
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final calculation = state.history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Тип файла
                        Text(
                          'Тип ${calculation['fileType'] == 1 ? 'Моно' : 'Стерео'}',
                          style: const TextStyle(fontSize: 16)
                        ),

                        // Частота
                        Text(
                          'Частота ${calculation['sampleRate']} Hz',
                          style: const TextStyle(fontSize: 16)
                        ),

                        // Глубина
                        Text(
                          'Глубина ${calculation['bitDepth']} bit',
                          style: const TextStyle(fontSize: 16)
                        ),

                        // Длина
                        Text(
                          'Длительность ${calculation['duration']} sec',
                          style: const TextStyle(fontSize: 16)
                        ),

                        const SizedBox(height: 8),

                        // Размер
                        Text(
                          'Размер ${calculation['formattedSize']}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),

                        const SizedBox(height: 8),

                        // Дата и время
                        Text(
                          '${_formatTimestamp(calculation['timestamp'])}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey)
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is AudioError) {
            return Center(child: Text('Ошибка ${state.message}'));
          } else {
            // Индикатор загрузки
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  // Выполнил Занин Вячеслав ВМК-22

  // Форматирование даты и времени
  String _formatTimestamp(String isoTimestamp) {
    final date = DateTime.parse(isoTimestamp).toLocal();

    return '${date.day}.${date.month}.${date.year}.${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}