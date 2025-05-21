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

  AudioCalculated(this.fileSize, this.formattedSize);
}

// Состояние ошибки (например, если данные невалидны)
class AudioError extends AudioState {
  final String message;

  AudioError(this.message);
}