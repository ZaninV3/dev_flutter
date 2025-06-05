import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  @override
  void onChange(Change<AudioState> change) {
    super.onChange(change);
    print('[CUBIT] State changed from ${change.currentState} to ${change.nextState}');
  }

  static const _historyKey = 'audio_calculations_history'; // Ключ для SharedPreferences

  // Загрузка истории при инициализации Cubit
  AudioCubit() : super(AudioInitial()) { // Начальное состояние
    _loadHistory();
  }

  // Метод сохранения расчета
  Future<void> _saveCalculation(Map<String, dynamic> calculation) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];  // Получение текущей истории

    historyJson.insert(0, jsonEncode(calculation));  // Добавление нового расчета в начало списка

    await prefs.setStringList(_historyKey, historyJson.take(100).toList());  // Сохранение (макс. 100 записей)
  }

  // Метод для загрузки истории 
  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList(_historyKey) ?? [];

      // Преобразование json строки обратно в Map
      final history = historyJson.map((json) =>
        Map<String, dynamic>.from(jsonDecode(json))).toList();

      emit(AudioHistory(history));  // Отправка нового состояния
    } catch (e) {
      emit(AudioError('Ошибка загрузки истории'));
    }
  }

  // Метод для расчета объема файла
  Future<void> calculateAudioSize({
    required int fileType,
    required int sampleRate,
    required int bitDepth,
    required double duration,
  }) async {
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

      // Формируем объект с данными 
      final calculationData = {
        'fileType': fileType,
        'sampleRate': sampleRate,
        'bitDepth': bitDepth,
        'duration': duration,
        'fileSize': fileSize,
        'formattedSize': formattedSize,
        'timestamp': DateTime.now().toIso8601String()  // Дата и время
      };

      emit(AudioCalculated(fileSize, formattedSize, calculationData)); // Успешный результат
      await _saveCalculation(calculationData);
    } catch (e) {
      print('[ERROR] Ошибка в calculateAudioSize: $e');
      emit(AudioError('Ошибка расчета: $e')); // Ошибка
    };
  }

  Future<void> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_historyKey);
      emit(AudioHistory([]));
    } catch (e) {
      emit(AudioError('Ошибка очистки истории'));
    }
  }

  void loadHistory() async {
    await _loadHistory();
  }
}