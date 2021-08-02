import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

const String openWeatherMapUri = 'api.openweathermap.org/data/2.5/weather';

const TextStyle kTextStyle = TextStyle(
  fontSize: 24.0,
  letterSpacing: 1.1,
);
const TextStyle kBoldTextStyle = TextStyle(
  fontSize: 24.0,
  letterSpacing: 1.2,
  fontWeight: FontWeight.bold,
);
const double kTextSizeLarge = 140.0;
const Color kRainyColor = Color(0xffDCDCDC);
const Color kSunnyColor = Color(0xffFFD500);
const WeatherModel errorWeather = WeatherModel(
    icon: 'icon',
    temperature: '0',
    country: 'country',
    city: 'city',
    windSpeed: 0,
    humidity: 0,
    description: 'description',
    maxTemperature: '0',
    minTemperature: '0');
