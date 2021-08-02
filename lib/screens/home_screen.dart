import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/services/constants.dart';
import 'package:weather_app/services/weather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.weather});

  final WeatherModel weather;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherModel weather;
  late String city;
  late String country;
  late String maxTemp;
  late String minTemp;
  late String temp;
  late int humidity;
  late String description;
  late double windSpeed;
  late String icon;
  @override
  void initState() {
    super.initState();
    weather = widget.weather;
    updateUI(weather);
  }

  void updateUI(WeatherModel weather) {
    setState(() {
      city = weather.city;
      country = weather.country;
      description = weather.description;
      humidity = weather.humidity;
      icon = weather.icon;
      maxTemp = weather.maxTemperature;
      minTemp = weather.minTemperature;
      temp = weather.temperature;
      windSpeed = weather.windSpeed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            '$city, $country',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                var city = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
                if (city != null) {
                  var weatherData =
                      await WeatherService().getWeatherByCity(city);
                  weather = WeatherModel.fromJson(weatherData);
                  updateUI(weather);
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TwoHeaderWidget(
                  children: [
                    Text(
                      'Friday',
                      style: kBoldTextStyle,
                    ),
                    Text(
                      '04 September',
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2.0,
                indent: 25.0,
                endIndent: 25.0,
              ),
              Expanded(
                flex: 3,
                child: TwoHeaderWidget(
                  children: [
                    getIconFromNetwork(icon),
                    Text(temp.toString(),
                        style: kTextStyle.copyWith(
                          fontSize: kTextSizeLarge,
                        )),
                    Text(
                      description,
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2.0,
                indent: 25.0,
                endIndent: 25.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TwoHeaderWidget(
                      children: [
                        Text(
                          maxTemp,
                          style: kBoldTextStyle,
                        ),
                        Text(
                          minTemp,
                          style: kTextStyle,
                        ),
                      ],
                    ),
                    TwoHeaderWidget(
                      children: [
                        Text(
                          '${humidity.toString()}% Humidity',
                          style: kBoldTextStyle,
                        ),
                        Text(
                          '${windSpeed.toString()} m/s Wind',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Image getIconFromNetwork(String icon) {
    return icon == 'icon'
        ? Image.asset('assets/sunny.png')
        : Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
  }
}

class TwoHeaderWidget extends StatelessWidget {
  final List<Widget> children;

  TwoHeaderWidget({required this.children});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
