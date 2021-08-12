import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utils/failure.dart';

class Location {
  late final double lon;
  late final double lat;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await this._determinePosition();
      lon = position.longitude;
      lat = position.latitude;
    } on LocationServiceDisabledException {
      throw Failure(
          'It seems like your location service is disabled. Please check it again.');
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }
}
