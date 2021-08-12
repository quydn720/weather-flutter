import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/theme/bloc/theme_bloc.dart';
import 'package:weather_app/bloc/weather/weather_bloc.dart';
import 'package:weather_app/screens/components/two_headers.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, weatherState) {
        if (weatherState is WeatherSuccessful) {
          BlocProvider.of<ThemeBloc>(context)
              .add(ThemeEventWeatherChanged(weather: weatherState.weather));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.list),
                onPressed: () {},
              ),
              centerTitle: true,
              title: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSuccessful) {
                    var weather = state.weather;
                    return Text('${weather.city}, ${weather.country}');
                  } else {
                    return Text('Weather Application');
                  }
                },
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
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherEventCityRequested(city: city));
                    }
                  },
                ),
              ],
            ),
            body: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return Center(child: Splash());
                }
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is WeatherSuccessful) {
                  var weather = state.weather;
                  return Padding(
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
                  );
                } else {
                  var error = state as WeatherFailed;
                  return Text(error.errorMessage);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Image getIconFromNetwork(String icon) {
    return icon == 'icon'
        ? Image.asset('assets/sunny.png')
        : Image.network('http://openweathermap.org/img/wn/$icon@2x.png');
  }

  String formattedTemp(double temp) => '${temp.toInt().toString()}°';
}
