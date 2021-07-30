import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/services/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService = WeatherService();
  late final WeatherModel weather;
  Future<void> getInitialData() async {
    var weatherData = await weatherService.getWeatherByLocation();
    weather = weatherService.parse(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitialData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            home: Scaffold(
              body: HomeScreen(
                weather: weather,
              ),
            ),
          );
        }
      },
    );
  }
}
