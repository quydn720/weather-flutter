import 'package:flutter/material.dart';
import 'package:weather_app/services/constants.dart';
import 'package:weather_app/services/weather.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String cityName;
  final WeatherService weatherService = WeatherService();

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
              style: kTextStyle.copyWith(color: Colors.black),
              onChanged: (input) {
                setState(() {
                  cityName = input;
                });
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context, cityName);
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
