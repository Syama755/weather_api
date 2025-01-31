import 'package:flutter/material.dart';

class WeatherModel {
final int lon;
final int lat;
final int weatherid;
final String main;
final String description;
final String icon;
final String base;
final int temp;
final int feels_like;
final int temp_min;
final int temp_max;
final int pressure;
final int humidity;
final int sea_level;
final int grnd_level;
final int visibility;
final int speed;
final int deg;
final int gust;
final int all;
final int dt;
final int type;
final int sysid;
final String country;
final int sunrise;
final int sunset;
final int timezone;
final int id;
final String name;
final int cod;
WeatherModel ({
  required this.all,
  required this.base,required this.cod,required this.country,required  this.deg, required this.description, required this.dt,required this.feels_like, required this.grnd_level
  ,required this.gust, required this.humidity, required this.icon, required this.id,required this.lat, required this.lon, required this.main, required this.name,
  required this.pressure, required this.sea_level,required this.speed,required this.sunrise,required this.sunset,required this.sysid,
  required this.temp, required this.temp_max , required this.temp_min, required this.timezone, required this.type, required this.visibility, required this.weatherid
});
factory WeatherModel.fromMap(Map<String,dynamic> WeatherModelMap){
  return WeatherModel(all: WeatherModelMap["clouds"]["all"], base: WeatherModelMap["base"], cod: WeatherModelMap["cod"], country: WeatherModelMap["sys"]["country"], deg: WeatherModelMap["wind"]["deg"], description: WeatherModelMap["weather"]["description"], dt: WeatherModelMap["dt"], feels_like: WeatherModelMap["main"]["feels_like"], grnd_level: WeatherModelMap["main"]["grnd_level"], gust: WeatherModelMap["wind"]["gust"], humidity: WeatherModelMap["main"]["humidity"], icon: WeatherModelMap["weather"]["icon"], id: WeatherModelMap["id"], lat: WeatherModelMap["coord"]["lat"], lon: WeatherModelMap["coord"]["lon"], main: WeatherModelMap["weather"]["main"], name: WeatherModelMap["name"], pressure: WeatherModelMap["main"]["pressure"], sea_level: WeatherModelMap["main"]["sea_level"], speed: WeatherModelMap["wind"]["speed"], sunrise: WeatherModelMap["sys"]["sunrise"], sunset: WeatherModelMap["sys"]["sunset"], sysid: WeatherModelMap["sys"]["id"], temp: WeatherModelMap["main"]["temp"], temp_max: WeatherModelMap["main"]["temp_max"], temp_min: WeatherModelMap["main"]["temp_min"], timezone: WeatherModelMap["timezone"], type:WeatherModelMap["sys"]["type"], visibility: WeatherModelMap["visibility"], weatherid: WeatherModelMap["weather"]["id"]);
}

}