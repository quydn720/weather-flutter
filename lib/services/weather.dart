import 'package:weather_app/constants.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

class WeatherService {
  Future<dynamic> getWeatherByLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://$openWeatherMapUri?lat=${location.lat}&lon=${location.lon}&appid=$apiKey&units=metric');
    return await networkHelper.getData();
  }

  WeatherModel parse(dynamic data) {
    double temp = data['main']['temp'];
    int temperature = temp.toInt();

    temp = data['main']['temp_min'];
    int minTemperature = temp.toInt();
    temp = data['main']['temp_max'];
    int maxTemperature = temp.toInt();
    double windSpeed = data['wind']['speed'];
    int humidity = data['main']['humidity'];
    String country = data['sys']['country'];
    String city = data['name'];
    String desc = data['weather'][0]['description'];
    return WeatherModel(
      temperature: temperature.toString() + '°',
      country: country,
      city: city,
      windSpeed: windSpeed,
      humidity: humidity,
      description: desc,
      maxTemperature: maxTemperature.toString() + '°C',
      minTemperature: minTemperature.toString() + '°C',
    );
  }
}

class WeatherModel {
  String temperature;
  String minTemperature;
  String maxTemperature;
  double windSpeed;
  int humidity;
  String country;
  String city;
  String description;

  WeatherModel({
    required this.temperature,
    required this.country,
    required this.city,
    required this.windSpeed,
    required this.humidity,
    required this.description,
    required this.maxTemperature,
    required this.minTemperature,
  });
}