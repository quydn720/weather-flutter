import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/components/two_headers.dart';
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

  late bool isNight;
  late bool isSunny;
  late ThemeKeys key;
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
      isNight = (weather.dt > weather.sunset);
      isSunny = (weather.temperature > 25);
      key = isNight
          ? ThemeKeys.nightly
          : (isSunny ? ThemeKeys.sunny : ThemeKeys.rainy);
    });
  }

  ThemeData getThemeData(ThemeKeys key) {
    ThemeData data;
    switch (key) {
      case ThemeKeys.nightly:
        data = ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kNightColor,
          textTheme: TextTheme(
            bodyText2: kTextStyle,
          ),
          appBarTheme: AppBarTheme().copyWith(
            color: kNightColor,
            elevation: 0,
          ),
        );
        break;
      case ThemeKeys.sunny:
        data = ThemeData.light().copyWith(
          scaffoldBackgroundColor: kSunnyColor,
          textTheme: TextTheme(
            bodyText2: kTextStyle,
          ),
          appBarTheme: AppBarTheme().copyWith(
            color: kSunnyColor,
            elevation: 0,
          ),
        );
        break;
      case ThemeKeys.rainy:
        data = ThemeData.light().copyWith(
          brightness: Brightness.light,
          scaffoldBackgroundColor: kRainyColor,
          textTheme:
              TextTheme(bodyText2: kTextStyle.copyWith(color: Colors.black)),
          appBarTheme: AppBarTheme().copyWith(
            color: kRainyColor,
            actionsIconTheme: IconThemeData().copyWith(color: Colors.black),
            iconTheme: IconThemeData().copyWith(color: Colors.black),
            elevation: 0,
          ),
        );
        break;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getThemeData(key),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoHeaders(
                  title: weekday,
                  subtitle: dayMonth,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2.0,
                  indent: kDividerOffset,
                  endIndent: kDividerOffset,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: getIconFromNetwork(icon)),
                      Expanded(
                        flex: 3,
                        child: FittedBox(child: Text(temp.toString())),
                      ),
                      Expanded(child: Text(description)),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  indent: kDividerOffset,
                  endIndent: kDividerOffset,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TwoHeaders(title: maxTemp, subtitle: minTemp),
                    TwoHeaders(
                      title: '${humidity.toString()}% Humidity',
                      subtitle: '${windSpeed.toString()} m/s Wind',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
              var weatherData = await WeatherService().getWeatherByCity(city);
              weather = WeatherModel.fromJson(weatherData);
              updateUI(weather);
            }
          },
        ),
      ],
    );
  }

  Image getIconFromNetwork(String icon) {
    return icon == 'icon'
        ? Image.asset('assets/sunny.png')
        : Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
  }
}
