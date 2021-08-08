import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/constants.dart';
import 'package:weather_app/services/weather.dart';

enum AppThemeKeys { sunny, rainy, nightly }

final Map<AppThemeKeys, ThemeData> _themes = {
  AppThemeKeys.sunny: ThemeData.light().copyWith(
    scaffoldBackgroundColor: kSunnyColor,
  ),
  AppThemeKeys.rainy: ThemeData.light().copyWith(
    scaffoldBackgroundColor: kRainyColor,
  ),
  AppThemeKeys.nightly: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kNightColor,
  ),
};

class ThemeProvider extends ChangeNotifier {
  static ThemeProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<ThemeProvider>(context, listen: listen);

  AppThemeKeys _themeKey = AppThemeKeys.sunny;

  ThemeData get currentTheme => _themes[_themeKey]!;
  AppThemeKeys get currentThemeKey => _themeKey;

  void setTheme(AppThemeKeys key) {
    _themeKey = key;
    notifyListeners();
  }
}

class WeatherData extends ChangeNotifier {
  late WeatherModel _weather;
  WeatherModel get weather => _weather;

  void setWeather(WeatherModel w) {
    _weather = w;
    notifyListeners();
  }
}
