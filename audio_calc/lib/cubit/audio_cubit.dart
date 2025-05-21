import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioInitial()); // Начальное состояние

  // Метод для расчета объема файла
  void calculateAudioSize({
    required int fileType,
    required int sampleRate,
    required int bitDepth,
    required double duration,
  }) {
    print('[DEBUG] Параметры: fileType=$fileType, sampleRate=$sampleRate, bitDepth=$bitDepth, duration=$duration');
    emit(AudioLoading()); // Переход в состояние загрузки

    try {
      // Формула расчета: (частота * глубина * каналы * время) / 8
      final fileSize = (sampleRate * bitDepth * fileType * duration) / 8;
      print('[DEBUG] Рассчитанный размер: $fileSize байт');

      // Форматирование результата
      String formattedSize;
      if (fileSize < 1024) {
        formattedSize = '${fileSize.toStringAsFixed(2)} байт';
      } else if (fileSize < 1024 * 1024) {
        formattedSize = '${(fileSize / 1024).toStringAsFixed(2)} КБ';
      } else if (fileSize < 1024 * 1024 * 1024) {
        formattedSize = '${(fileSize / (1024 * 1024)).toStringAsFixed(2)} МБ';
      } else if (fileSize < 1024 * 1024 * 1024 * 1024) {
        formattedSize = '${(fileSize / (1024 * 1024 * 1024)).toStringAsFixed(2)} ГБ';
      } else {
        formattedSize = '${(fileSize / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(2)} ТБ';
      }

      emit(AudioCalculated(fileSize, formattedSize)); // Успешный результат
    } catch (e) {
      print('[ERROR] Ошибка в calculateAudioSize: $e');
      emit(AudioError('Ошибка расчета: $e')); // Ошибка
    }
  }
}