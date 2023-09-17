import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/home_page.dart';
import 'package:weather/location.dart';
import 'package:weather/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      Location currentPosition = Location();
      await currentPosition.getPosition();

      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitud}&lon=${currentPosition.longitud}&appid=44c764c46837f9658c3230fdbf748507&units=metric";
      Weather currentWeather = Weather(url);
      var weatherData = await currentWeather.getWeather();

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return HomePage(weather: weatherData);
          }
      ));
      print(weatherData);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
