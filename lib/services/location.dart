import 'package:geolocator/geolocator.dart';

class Location {
  late double lon;
  late double lat;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      lon = position.longitude;
      lat = position.latitude;
    } catch (e) {
      print(e);
    }
  }
}
