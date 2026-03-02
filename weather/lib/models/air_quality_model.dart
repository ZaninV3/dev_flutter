import 'package:hive/hive.dart';

part 'air_quality_model.g.dart';  // Был сгенерирован build_runner

@HiveType(typeId: 0)
class AirQuality {
  @HiveField(0)
  final String city;

  @HiveField(1)
  final int aqi;

  @HiveField(2)
  final DateTime timestamp;

  AirQuality({
    required this.city,
    required this.aqi,
    required this.timestamp
  });
}