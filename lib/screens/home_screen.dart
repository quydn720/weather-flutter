import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/components/two_headers.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  // late final ThemeKeys _key;
  //     isNight = (weather.dt > weather.sunset);
  //     isSunny = (weather.temperature > 25);
  //     key = isNight
  //         ? ThemeKeys.nightly
  //         : (isSunny ? ThemeKeys.sunny : ThemeKeys.rainy);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

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
            brightness: Brightness.light,
            scaffoldBackgroundColor: kSunnyColor,
            textTheme: TextTheme(
              bodyText2: kTextStyle.copyWith(color: Colors.black),
            ),
            appBarTheme: AppBarTheme().copyWith(
              color: kSunnyColor,
              textTheme: TextTheme(
                  headline6: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              actionsIconTheme: IconThemeData().copyWith(color: Colors.black),
              iconTheme: IconThemeData().copyWith(color: Colors.black),
              elevation: 0,
            ),
          );
          break;
        case ThemeKeys.rainy:
          data = ThemeData.light().copyWith(
            brightness: Brightness.light,
            scaffoldBackgroundColor: kRainyColor,
            textTheme: TextTheme(
              bodyText2: kTextStyle.copyWith(color: Colors.black),
            ),
            appBarTheme: AppBarTheme().copyWith(
              color: kRainyColor,
              textTheme: TextTheme(
                headline6: TextStyle(color: Colors.black, fontSize: 20),
              ),
              actionsIconTheme: IconThemeData().copyWith(color: Colors.black),
              iconTheme: IconThemeData().copyWith(color: Colors.black),
              elevation: 0,
            ),
          );
          break;
      }
      return data;
    }

    return BlocConsumer<WeatherBloc, WeatherState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is WeatherSuccessful) {
          var weather = state.weather;
          return Body(
            weather: weather,
            date: date,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TwoHeaders(
                    title: DateFormat()
                        .addPattern(DateFormat.WEEKDAY)
                        .format(date),
                    subtitle: DateFormat()
                        .addPattern(DateFormat.DAY)
                        .addPattern(DateFormat.MONTH)
                        .format(date),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 2.0,
                      indent: kDividerOffset,
                      endIndent: kDividerOffset,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: getIconFromNetwork(weather.icon)),
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                            child: Text(
                              formattedTemp(weather.temperature),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(weather.description),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 2.0,
                      indent: kDividerOffset,
                      endIndent: kDividerOffset,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TwoHeaders(
                        title: formattedTemp(weather.maxTemperature),
                        subtitle: formattedTemp(weather.minTemperature),
                      ),
                      TwoHeaders(
                        title: '${weather.humidity}% Humidity',
                        subtitle: '${weather.windSpeed} m/s Wind',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          var error = state as WeatherFailed;
          return Text(error.errorMessage);
        }
      });
    });
  }

  Image getIconFromNetwork(String icon) {
    return icon == 'icon'
        ? Image.asset('assets/sunny.png')
        : Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
  }

  String formattedTemp(double temp) => '${temp.toInt().toString()}°';
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.weather,
    required this.date,
    required this.child,
  }) : super(key: key);

  final Weather weather;
  final DateTime date;
  final Widget child;

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.list),
        onPressed: () {},
      ),
      centerTitle: true,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            var city = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
            if (city != null) {
              BlocProvider.of<WeatherBloc>(context)
                  .add(WeatherEventCityRequested(city: city));
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, '${weather.city}, ${weather.country}'),
      body: SafeArea(child: child),
    );
  }
}
