part of 'audio_cubit.dart';

// Базовое состояние
abstract class AudioState {}

// Начальное состояние (пустое)
class AudioInitial extends AudioState {}

// Состояние загрузки (например, при расчете)
class AudioLoading extends AudioState {}

// Состояние с результатом расчета
class AudioCalculated extends AudioState {
  final double fileSize; // Размер файла в байтах
  final String formattedSize; // Отформатированный размер (например, "5.2 МБ")
  final Map<String, dynamic> calcData;  // все параметры + результат 

  AudioCalculated(this.fileSize, this.formattedSize, this.calcData);
}

// Состояние ошибки (например, если данные невалидны)
class AudioError extends AudioState {
  final String message;

  AudioError(this.message);
}

// Состояние истории
class AudioHistory extends AudioState {
  final List<Map<String, dynamic>> history;  // Список всех расчетов

  AudioHistory(this.history);
}