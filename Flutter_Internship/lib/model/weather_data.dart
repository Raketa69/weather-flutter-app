import 'dart:convert';
import 'dart:core';

class Weather {
  double? temp;
  double? tempMin;
  double? tempMax;
  var icon;
  String? main;
  String? description;
  String? name;
  String? country;

  Weather(
      {
        this.temp,
        this.tempMin,
        this.tempMax,
        this.icon,
        this.main,
        this.description,
        this.name,
        this.country,
      });

  Weather.fromJson(Map<String, dynamic> json) {
      temp = json["main"]['temp'];
      tempMin = json["main"]["temp_min"];
      tempMax = json["main"]['temp_max'];
      icon = json['weather'][0]['icon'];
      main =  json["weather"][0]['main'];
      description = json["weather"][0]['description'];
      name = json["name"];
      country = json["sys"]["country"];
  }
}