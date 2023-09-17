import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/home_page.dart';
import 'package:weather/weather.dart';

class LoadingScreenWithCity extends StatefulWidget {
  final String cityName;

  LoadingScreenWithCity({required this.cityName});

  @override
  State<LoadingScreenWithCity> createState() => _LoadingScreenWithCityState();
}

class _LoadingScreenWithCityState extends State<LoadingScreenWithCity> {
  @override
  void initState() {
    super.initState();
    getDataForCity();
  }

  void getDataForCity() async {
    final url = "https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=44c764c46837f9658c3230fdbf748507&units=metric";
    Weather currentWeather = Weather(url);
    var weatherData = await currentWeather.getWeather();

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return HomePage(weather: weatherData);
      },
    ));

    print(weatherData);
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
