import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late String windSpeed;
  late String icon;
  late String weekday;
  late String dayMonth;
  late Color textColor;
  late Color backgroundColor;
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
      maxTemp = '${weather.maxTemperature.toString()} °C';
      minTemp = '${weather.minTemperature.toString()} °C';
      temp = '${weather.temperature.toString()} °';
      windSpeed = weather.windSpeed;
      DateTime date = DateTime.now();

      weekday = DateFormat().addPattern(DateFormat.WEEKDAY).format(date);
      dayMonth = DateFormat()
          .addPattern(DateFormat.DAY)
          .addPattern(DateFormat.MONTH)
          .format(date);
      bool isNight = (DateTime.fromMicrosecondsSinceEpoch(weather.dt * 1000000)
              .toUtc()
              .hour >
          12);
      bool isSunny = (weather.temperature > 25);
      textColor = isNight ? Colors.white : Colors.black;
      backgroundColor =
          isNight ? kNightColor : (isSunny ? kSunnyColor : kRainyColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading: IconButton(
              icon: Icon(Icons.list, color: textColor),
              onPressed: () {},
            ),
            centerTitle: true,
            title: Text(
              '$city, $country',
              style: TextStyle().copyWith(color: textColor),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: textColor),
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            weekday,
                            style: kBoldTextStyle.copyWith(color: textColor),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            dayMonth,
                            style: kTextStyle.copyWith(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: textColor,
                      thickness: 2.0,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: getIconFromNetwork(icon)),
                        Expanded(
                          flex: 5,
                          child: Text(
                            temp.toString(),
                            style: kTextStyle.copyWith(
                              fontSize: kTextSizeLarge,
                              color: textColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            description,
                            style: kTextStyle.copyWith(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: textColor,
                      thickness: 2.0,
                      indent: 25.0,
                      endIndent: 25.0,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  maxTemp,
                                  style:
                                      kBoldTextStyle.copyWith(color: textColor),
                                ),
                              ),
                              Expanded(
                                child: Text(minTemp,
                                    style:
                                        kTextStyle.copyWith(color: textColor)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${humidity.toString()}% Humidity',
                                  style:
                                      kBoldTextStyle.copyWith(color: textColor),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${windSpeed.toString()} m/s Wind',
                                  style: kTextStyle.copyWith(color: textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Image getIconFromNetwork(String icon) {
    return icon == 'icon'
        ? Image.asset('assets/sunny.png')
        : Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
  }
}
