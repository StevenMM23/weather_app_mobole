import 'package:flutter/material.dart';
import 'package:weather/loading_screen.dart';
import 'package:weather/loading_screen_with_city.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _cityNameController = TextEditingController();

  void getWeatherForCity(String cityName) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return LoadingScreenWithCity(cityName: cityName);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccionar Ciudad"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityNameController,
                decoration: InputDecoration(
                  labelText: "Nombre de la Ciudad",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String cityName = _cityNameController.text.trim();
                  if (cityName.isNotEmpty) {
                    getWeatherForCity(cityName);
                  }
                },
                child: Text("Obtener Clima"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
