import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

class Location{

  var latitud;
  var longitud;

  Future<void> getPosition() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitud = position.latitude;
        longitud = position.longitude;
        print('Latitud: ${position.latitude}, Longitud ${position.longitude}');
      }
    } catch (error) {
      print(error);
    }
  }
}