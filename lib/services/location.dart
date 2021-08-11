import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class Location extends Equatable {
  late final double lon;
  late final double lat;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await this._determinePosition();
      lon = position.longitude;
      lat = position.latitude;
    } catch (e) {
      return Future.error("Can't get location of your device");
    }
  }

  Future<Position> _determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  List<Object?> get props => [lon, lat];
}
