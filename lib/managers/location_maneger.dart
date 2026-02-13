import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationManager {
  Future<LatLng> _getMyLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print("lat:  ........  ${position.latitude}");
    print(position.longitude);

    return LatLng(position.latitude, position.longitude);
  }

  Future<LatLng> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if ((await Geolocator.requestPermission() ==
              LocationPermission.whileInUse) ||
          (await Geolocator.requestPermission() == LocationPermission.always)) {
        return await _getMyLocation();
      }
      return LatLng(0, 0);
    } else {
      return await _getMyLocation();
    }
  }
}
