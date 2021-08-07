import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

import '../apiKey.dart';
import 'constants.dart';

class WeatherService {
  Future<dynamic> getWeatherByLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'https://$openWeatherMapUri?lat=${location.lat}&lon=${location.lon}&appid=$apiKey&units=metric');
    return await networkHelper.getData();
  }

  Future<dynamic> getWeatherByCity(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://$openWeatherMapUri?q=$cityName&appid=$apiKey&units=metric');
    return await networkHelper.getData();
  }
}

class WeatherModel {
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final String windSpeed;
  final int humidity;
  final String country;
  final String city;
  final String description;
  final String icon;
  final int dt;

  const WeatherModel({
    required this.icon,
    required this.temperature,
    required this.country,
    required this.city,
    required this.windSpeed,
    required this.humidity,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
    required this.dt,
  });

  static WeatherModel fromJson(Map<String, dynamic> data) {
    // try {
    double temp = data['main']['temp'];
    int temperature = temp.toInt();

    temp = data['main']['temp_min'];
    int minTemperature = temp.toInt();
    temp = data['main']['temp_max'];
    int maxTemperature = temp.toInt();
    String windSpeed = data['wind']['speed'].toString();
    int humidity = data['main']['humidity'];
    String country = data['sys']['country'];
    String city = data['name'];
    String desc = data['weather'][0]['description'];
    String icon = data['weather'][0]['icon'];
    int dt = data['dt'];

    return WeatherModel(
      icon: icon,
      temperature: temperature,
      country: country,
      city: city,
      windSpeed: windSpeed,
      humidity: humidity,
      description: desc,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
      dt: dt,
    );
    //}
    // catch (e) {
    //   return errorWeather;
    // }
  }
}
