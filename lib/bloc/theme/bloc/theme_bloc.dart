import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(color: kNightColor));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeEventWeatherChanged) {
      var weather = event.weather;

      if (weather.dt > weather.sunset) {
        yield ThemeState(color: kNightColor);
      } else if (weather.temperature > 25) {
        yield ThemeState(isNight: false, color: kSunnyColor);
      } else {
        yield ThemeState(isNight: false, color: kRainyColor);
      }
    }
  }
}
