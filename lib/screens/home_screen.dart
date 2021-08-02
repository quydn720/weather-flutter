import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/constants.dart';
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
          leading: IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            '${weather.city}, ${weather.country}',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
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
                    getIconFromNetwork(weather.icon),
                    Text(weather.temperature.toString(),
                        style: kTextStyle.copyWith(
                          fontSize: kTextSizeLarge,
                        )),
                    Text(
                      weather.description,
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
                          weather.maxTemperature,
                          style: kBoldTextStyle,
                        ),
                        Text(
                          weather.minTemperature,
                          style: kTextStyle,
                        ),
                      ],
                    ),
                    TwoHeaderWidget(
                      children: [
                        Text(
                          '${weather.humidity.toString()}% Humidity',
                          style: kBoldTextStyle,
                        ),
                        Text(
                          '${weather.windSpeed.toString()} m/s Wind',
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
