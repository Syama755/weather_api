import 'dart:convert';

import 'package:weatherapp/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
   Future<WeatherModel> getWeatherModel()async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=a0e7dce707052a4a925385b8737a67d0"));
    print(response.body);
    return WeatherModel.fromMap(jsonDecode(response.body));
  }
  Future<WeatherModel> getWeatherModel2()async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=city&appid=a0e7dce707052a4a925385b8737a67d0"));
    print(response.body);
    return WeatherModel.fromMap(jsonDecode(response.body));
  }

}