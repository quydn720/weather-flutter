import 'package:flutter/material.dart';

const String openWeatherMapUri = 'api.openweathermap.org/data/2.5/weather';
const TextStyle kTextStyle = TextStyle(
  fontSize: 24.0,
);

const double kDividerOffset = 10.0;
const Color kRainyColor = Color(0xffDCDCDC);
const Color kSunnyColor = Color(0xffFFD500);
const Color kNightColor = Color(0xff010032);

enum ThemeKeys { sunny, rainy, nightly }
