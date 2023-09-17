import 'package:flutter/material.dart';
import 'package:weather/city_screen.dart';
import 'package:weather/loading_screen.dart';
import 'package:weather/location.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.weather}) : super(key: key);

  final dynamic weather;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temperature = "";
  String imageURL = "";

  void updateLocation() async {
    setState(() {
      temperature = "";
    });

    Location currentPosition = Location();
    await currentPosition.getPosition();

    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition.latitud}&lon=${currentPosition.longitud}&appid=44c764c46837f9658c3230fdbf748507&units=metric";
    Weather currentWeather = Weather(url);
    var weatherData = await currentWeather.getWeather();

    setState(() {
      temperature = weatherData["main"]["temp"].toStringAsFixed(2);
    });
  }

  void navigateToCityScreen() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return CityScreen();
        }
    ));
  }

  void updateWeatherForCity(String cityName) async {
    final url = "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=44c764c46837f9658c3230fdbf748507&units=metric";
    Weather currentWeather = Weather(url);
    var weatherData = await currentWeather.getWeather();

    // Llama a la función onUpdateCityWeather para actualizar los datos en HomePage
    setState(() {
      temperature = int.parse(weatherData["main"]["temp"]).toString();
      String icon = weatherData["weather"][0]["icon"];
      imageURL = getIconURL(icon);
    });

    Navigator.pop(context); // Cierra la pantalla actual
  }

  @override
  void initState() {
    super.initState();
    Ejemplo();
  }

  void Ejemplo() {
    // Obtener la temperatura
    temperature = widget.weather["main"]["temp"].toStringAsFixed(2);

    // Obtener el icono meteorológico
    String icon = widget.weather["weather"][0]["icon"];

    // Obtener la URL de la imagen
    imageURL = getIconURL(icon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de pantalla
          Image.asset(
            'assets/location_background.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      updateLocation();
                    },
                    icon: Icon(Icons.location_on, color: Colors.white, size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      navigateToCityScreen();
                    },
                    icon: Icon(Icons.location_city, color: Colors.white, size: 30),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${temperature}°C",
                            style: TextStyle(fontSize: 57, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Image.network(
                            imageURL,
                            width: 50.0,
                            height: 50.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  String getIconURL(String icon) {
    return "https://openweathermap.org/img/wn/$icon.png";
  }
}
