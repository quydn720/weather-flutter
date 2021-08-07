import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/services/weather.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final WeatherService weatherService = WeatherService();
  late Future<WeatherModel> weather;

  Future<WeatherModel> getInitialData() async {
    var location = await weatherService.getWeatherByLocation();
    return WeatherModel.fromJson(location);
  }

  @override
  void initState() {
    weather = getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weather,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          return HomeScreen(weather: snapshot.data);
        }
      },
    );
  }
}
