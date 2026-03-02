import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';
import '../models/air_quality_model.dart';
part 'air_quality_state.dart';

class AirQualityCubit extends Cubit<AirQualityState> {
  final Box<AirQuality> historyBox;

  AirQualityCubit({required this.historyBox}) : super(AirQualityInitial());

  static const String apiKey = 'API_KEY';
  static const String baseUrl = 'http://api.airvisual.com/v2/city';

  Future<void> fetchAirQuality(String city, String state, String country) async {
    emit(AirQualityLoading());
    try {
      final url = Uri.parse('$baseUrl?city=$city&state=$state&country=$country&key=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aqi = data['data']['current']['pollution']['aqius'];

        // Сохранение в историю
        final airQuality = AirQuality(
          city: city,
          aqi: aqi,
          timestamp: DateTime.now()
        );
        await historyBox.add(airQuality);  // Добавление в Hive

        emit(AirQualityLoaded(airQuality: airQuality));
      } else {
        emit(AirQualityError(message: 'Ошибка загрузки данных'));
      }
    } catch (e) {
      emit(AirQualityError(message: 'Ошибка: $e'));
    }
  }

  // Оценка качества воздуха AQI
  String getAqiAssessment(int aqi) {
    if (aqi <= 50) return 'Хорошо';
    if (aqi <= 100) return 'Умеренно';
    if (aqi <= 150) return 'Нездорово для чувствительных групп';
    if (aqi <= 200) return 'Нездорово';
    if (aqi <= 300) return 'Очень нездорово';
    return 'Опасно';
  }
}