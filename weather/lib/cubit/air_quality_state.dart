part of 'air_quality_cubit.dart';

@immutable
abstract class AirQualityState {}

class AirQualityInitial extends AirQualityState {}
class AirQualityLoading extends AirQualityState {}
class AirQualityLoaded extends AirQualityState {
  final AirQuality airQuality;
  AirQualityLoaded({required this.airQuality});
}
class AirQualityError extends AirQualityState {
  final String message;
  AirQualityError({required this.message});
}