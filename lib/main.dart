import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/theme/bloc/theme_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/services/weather_repository.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository();

  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: MyApp(
      weatherRepository: weatherRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme().copyWith(
              color: state.color,
              elevation: 0,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actionsIconTheme: IconThemeData().copyWith(color: Colors.black),
              iconTheme: IconThemeData().copyWith(color: Colors.black),
            ),
            scaffoldBackgroundColor: state.color,
            textTheme: TextTheme(
              bodyText2: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme().copyWith(
              color: state.color,
              elevation: 0,
            ),
            scaffoldBackgroundColor: state.color,
            brightness: Brightness.dark,
            textTheme: TextTheme(
              bodyText2: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          themeMode: state.isNight ? ThemeMode.dark : ThemeMode.light,
          home: BlocProvider<WeatherBloc>(
            create: (context) {
              return WeatherBloc(weatherRepository: weatherRepository)
                ..add(WeatherEventRequested());
            },
            child: HomeScreen(),
          ),
        );
      },
    );
  }
}
