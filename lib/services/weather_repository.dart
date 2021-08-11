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
