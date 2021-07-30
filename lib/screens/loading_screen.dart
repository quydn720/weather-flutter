import 'package:weather_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherService weatherService = WeatherService();
  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  Future<void> getInitialData() async {
    var weatherData = await weatherService.getWeatherByLocation();
    WeatherModel weather = weatherService.parse(weatherData);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return HomeScreen(
          weather: weather,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.black,
        size: 100.0,
      ),
    );
  }
}
