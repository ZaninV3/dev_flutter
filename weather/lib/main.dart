import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/developer_screen.dart';
import 'screens/home_screen.dart';
import 'models/air_quality_model.dart';
import 'cubit/air_quality_cubit.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AirQualityAdapter());
  await Hive.openBox<AirQuality>('airQualityHistory');

  runApp(AQIApp());
}

class AQIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AirQualityCubit(
          historyBox: Hive.box<AirQuality>('airQualityHistory')
        ),
        child: HomeScreen()
      ),
      routes: {
        '/developer': (context) => DeveloperScreen(),
      }
    );
  }
}
