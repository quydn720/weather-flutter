import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/weather_repository.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository();

  runApp(MyApp(
    weatherRepository: weatherRepository,
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<WeatherBloc>(
        create: (context) {
          return WeatherBloc(weatherRepository: weatherRepository)
            ..add(WeatherEventRequested());
        },
        child: HomeScreen(),
      ),
    );
  }
}
