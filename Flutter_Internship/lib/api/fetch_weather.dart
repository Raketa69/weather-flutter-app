import 'dart:convert';
import 'package:flutter_internship/api/api_key.dart';
import 'package:flutter_internship/model/weather_data.dart';
import 'package:http/http.dart' as http;

class FetchWeatherAPI {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$location&APPID=$apiKey&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(endpoint);
    print(body);
    return Weather.fromJson(body);
  }

  Future<dynamic> getCurrentWeatherListCities(String? location) async {
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/find?q=${location}&appid=$apiKey");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(endpoint);
    /*print('///////////////    message      /////////////////');*/
    print(body);
    //print('//////////////////////////////////////////////');
    var tmp = body['list'];
    //var tmp = from(body);
    /*print('///////////////    tmp      /////////////////');
    print(tmp);
    print('//////////////////////////////////////////////');*/
    return tmp;
  }
}