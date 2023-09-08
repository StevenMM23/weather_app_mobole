import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

class Location{

  var latitud;
  var longitud;

  Future<void> getPosition() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print('Latitud: ${position.latitude}, Longitud ${position.longitude}');
    }
    catch (error){
      print(error);
    }

  }

}