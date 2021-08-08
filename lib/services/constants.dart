import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

const String openWeatherMapUri = 'api.openweathermap.org/data/2.5/weather';

const TextStyle kTextStyle = TextStyle(
  fontSize: 24.0,
);

const double kDividerOffset = 10.0;
const Color kRainyColor = Color(0xffDCDCDC);
const Color kSunnyColor = Color(0xffFFD500);
const Color kNightColor = Color(0xff010032);

enum ThemeKeys { sunny, rainy, nightly }

const WeatherModel errorWeather = WeatherModel(
  sunrise: 0,
  sunset: 0,
  icon: 'icon',
  temperature: 0,
  country: 'country',
  city: 'city',
  windSpeed: '',
  humidity: 0,
  description: 'description',
  maxTemperature: 0,
  minTemperature: 0,
  dt: 0,
);
