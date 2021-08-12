part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent {
  @override
  List<Object?> get props => [];
}

class WeatherEventCityRequested extends WeatherEvent {
  final String city;
  const WeatherEventCityRequested({required this.city});
  @override
  List<Object?> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;
  const WeatherEventRefresh({required this.city});
  @override
  List<Object?> get props => [city];
}
