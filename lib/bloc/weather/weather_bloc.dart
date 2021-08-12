import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherEventRequested) {
      yield WeatherLoading();
      try {
        final data = await weatherRepository.getWeatherByLocation();
        yield WeatherSuccessful(weather: Weather.fromJson(data));
      } on SocketException {
        yield WeatherFailed('Check again your connection.');
      }
    } else if (event is WeatherEventCityRequested) {
      yield WeatherLoading();
      try {
        final data = await weatherRepository.getWeatherByCity(event.city);
        yield WeatherSuccessful(weather: Weather.fromJson(data));
      } catch (e) {
        print(e);
        yield WeatherFailed('Opps... There are some error.');
      }
    } else if (event is WeatherEventRefresh) {
      try {
        final data = await weatherRepository.getWeatherByCity(event.city);
        Weather.fromJson(data);
        yield WeatherSuccessful(weather: Weather.fromJson(data));
      } catch (e) {
        print(e);
        yield WeatherFailed('Opps... There are some error.');
      }
    }
  }
}
