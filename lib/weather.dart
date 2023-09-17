import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Weather{
  final url;
  Weather(this.url);

  Future getWeather() async{
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse;
    }

  }
}