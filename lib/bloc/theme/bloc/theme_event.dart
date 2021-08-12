part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final Weather weather;

  ThemeEventWeatherChanged({required this.weather});

  @override
  List<Object> get props => [weather];
}
