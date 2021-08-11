import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final String windSpeed;
  final int humidity;
  final String country;
  final String city;
  final String description;
  final String icon;
  final int dt;
  final int sunrise;
  final int sunset;

  Weather(
      {this.city = '',
      this.country = '',
      this.description = '',
      this.dt = 0,
      this.humidity = 0,
      this.icon = '',
      this.maxTemperature = 0.0,
      this.minTemperature = 0.0,
      this.sunrise = 0,
      this.sunset = 0,
      this.temperature = 0.0,
      this.windSpeed = ''});

  factory Weather.fromJson(Map<String, dynamic> data) => Weather(
        sunrise: data['sys']['sunrise'],
        sunset: data['sys']['sunset'],
        icon: data['weather'][0]['icon'],
        temperature: data['main']['temp'],
        country: data['sys']['country'],
        city: data['name'],
        windSpeed: data['wind']['speed'].toString(),
        humidity: data['main']['humidity'],
        description: data['weather'][0]['description'],
        maxTemperature: data['main']['temp_max'],
        minTemperature: data['main']['temp_min'],
        dt: data['dt'],
      );

  @override
  List<Object?> get props => [
        temperature,
        minTemperature,
        maxTemperature,
        windSpeed,
        humidity,
        country,
        city,
        description,
        icon,
        dt,
        sunrise,
        sunset,
      ];
}
