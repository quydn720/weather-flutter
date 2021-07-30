import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.weather});

  final WeatherModel weather;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    WeatherModel weather = widget.weather;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${weather.city}, ${weather.country}',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Card(
              color: Color(0xff5772FF),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Heavy Rain'),
                        Text('Morning'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    children: [
                      Text(
                        '29',
                        style: TextStyle(
                          fontSize: 60.0,
                        ),
                      ),
                      Text(
                        'Feel like 30',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child:
                  Image.network('http://openweathermap.org/img/wn/10d@2x.png'),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text('Temp'),
                        Text(weather.temperature.toString()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text('Wind'),
                        Text(weather.windSpeed.toString()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text('Humidity'),
                        Text('${weather.humidity.toString()}%'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
