import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/location.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
              TextButton(
                  onPressed: () async{
                    Location getCurrentLocation = Location();
                    getCurrentLocation.getPosition();
                  },
                  child: Text("Get location")
              )
            ],
          ),
      ),
    );
  }
}
