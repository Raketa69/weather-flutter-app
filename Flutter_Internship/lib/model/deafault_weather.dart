import 'package:flutter_internship/model/weather_data.dart';

class DefaultWeather extends Weather {
  var temp;
  double? tempMin;
  double? tempMax;
  var icon;
  String? main;
  String? description;
  String? name;
  String? country;

  DefaultWeather(){
    this.temp = 23;
    this.tempMin = 33;
    this.tempMax = 33;
    this.icon = 'cloud';
    this.main = 'Drizzle';
    this.description = 'Light intensity drizzle';
    this.name = 'Odessa, ';
    this.country = 'Ukraine';
  }
}