import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/air_quality_model.dart';
import '../cubit/air_quality_cubit.dart';

// Главный экран
class HomeScreen extends StatelessWidget {
  final TextEditingController city_controller = TextEditingController();
  final TextEditingController state_controller = TextEditingController();
  final TextEditingController country_controller = TextEditingController();

  HomeScreen({super.key});

  void _openPollutionMap(BuildContext context) async {
    const url = 'https://www.iqair.com/earth';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не удалось открыть карту')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Качество воздуха')),
      body: BlocConsumer<AirQualityCubit, AirQualityState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Поля ввода
                TextField(controller: city_controller, decoration: InputDecoration(labelText: 'Город')),
                TextField(controller: state_controller, decoration: InputDecoration(labelText: 'Регион')),
                TextField(controller: country_controller, decoration: InputDecoration(labelText: 'Страна')),

                // Кнопка запроса
                ElevatedButton(
                  onPressed: () => context.read<AirQualityCubit>().fetchAirQuality(
                    city_controller.text,
                    state_controller.text,
                    country_controller.text
                  ),
                  child: Text('Получить качество воздуха')
                ),

                if (state is AirQualityLoading) CircularProgressIndicator(),
                if (state is AirQualityError) Text(state.message, style: TextStyle(color: Colors.red)),
                if (state is AirQualityLoaded) Column(
                  children: [
                    Text('AQI: ${state.airQuality.aqi}'),
                    Text('Оценка ${context.read<AirQualityCubit>().getAqiAssessment(state.airQuality.aqi)}')
                  ]
                ),

                // Доп кнопки
                ElevatedButton(
                  onPressed: () =>_openPollutionMap(context),
                  child: Text('Открыть карту загрязнений')
                ),

                // История
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<AirQuality>('airQualityHistory').listenable(),
                    builder: (context, Box<AirQuality> box, _) {
                      final history = box.values.toList().reversed.toList();
                      return ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(history[index].city),
                          subtitle: Text('AQI: ${history[index].aqi}'),
                          trailing: Text(history[index].timestamp.toString())
                        ),
                      );
                    }
                  )
                )
              ]
            )
          );
        },
        listener: (context, state) {}
      )
    );
  }
}
