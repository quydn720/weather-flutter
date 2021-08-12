import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import '../utils/apiKey.dart';
import '../utils/constants.dart';

class WeatherRepository {
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
