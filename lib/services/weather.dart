import 'package:weather_app/constants.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

class WeatherService {
  Future<dynamic> getWeatherByLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://$openWeatherMapUri?lat=${location.lat}&lon=${location.lon}&appid=$apiKey');
    return await networkHelper.getData();
  }

  WeatherModel parse(dynamic data) {
    double temp = data['main']['temp'];

    double windSpeed = data['wind']['speed'];
    int humidity = data['main']['humidity'];
    String country = data['sys']['country'];
    int temperature = temp.toInt();
    String city = data['name'];
    return WeatherModel(
      temperature: temperature,
      country: country,
      city: city,
      windSpeed: windSpeed,
      humidity: humidity,
    );
  }
}

class WeatherModel {
  int temperature;
  double windSpeed;
  int humidity;
  String country;
  String city;

  WeatherModel({
    required this.temperature,
    required this.country,
    required this.city,
    required this.windSpeed,
    required this.humidity,
  });
}
