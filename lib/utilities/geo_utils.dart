import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeoUtils {
  static Future<LatLng?> getUserPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {}

    // Check and request permissions if needed
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );

    return LatLng(position.latitude, position.longitude);
  }

  static double calculateDistanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double R = 6371000; // raggio terrestre in metri
    final double dLat = degToRad(lat2 - lat1);
    final double dLon = degToRad(lon2 - lon1);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(degToRad(lat1)) *
            cos(degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // distanza in metri
  }

  static double degToRad(double deg) => deg * pi / 180;

  static isCloserTahn10Meters(LatLng latLng1, LatLng latLng2) {
    return calculateDistanceMeters(
          latLng1.latitude,
          latLng1.longitude,
          latLng2.latitude,
          latLng2.longitude,
        ) <=
        10;
  }
}
