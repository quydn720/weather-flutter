import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/services/weather.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String cityName;
  final WeatherService weatherService = WeatherService();
  late final WeatherModel weather;
  Future<void> getInitialData(String city) async {
    var weatherData = await weatherService.getWeatherByCity(city);
    weather = weatherService.parse(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter city name',
              ),
              style: kTextStyle,
              onChanged: (input) {
                setState(() {
                  cityName = input;
                });
              },
            ),
            TextButton(
              onPressed: () async {
                await getInitialData(cityName);
                setState(() {
                  Navigator.pop(context, weather);
                  print(weather.country);
                });
              },
              child: Text('Search'),
            )
          ],
        ),
      ),
    );
  }
}
