import 'package:weather_forecast/data/models/weather_model.dart';
import 'package:weather_forecast/domain/entities/weather_hourly_entity.dart';

class WeatherHourlyModel extends WeatherHourlyEntity {
  const WeatherHourlyModel({
    required super.dt,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uvi,
    required super.clouds,
    required super.visibility,
    required super.windSpeed,
    required super.windDeg,
    required super.windGust,
    required super.weather,
    required super.pop,
  });

  factory WeatherHourlyModel.fromJson(Map<String, dynamic> json) {
    return WeatherHourlyModel(
      dt: json['dt'] as int?,
      temp: json['temp'] is double? ? json['temp'] : json['temp'].toDouble(),
      feelsLike: json['feels_like'] is double?
          ? json['feels_like']
          : json['feels_like'].toDouble(),
      pressure: json['pressure'] as int?,
      humidity: json['humidity'] as int?,
      dewPoint: json['dew_point'] is double?
          ? json['dew_point']
          : json['dew_point'].toDouble(),
      uvi: json['uvi'] is double? ? json['uvi'] : json['uvi'].toDouble(),
      clouds: json['clouds'] as int?,
      visibility: json['visibility'] as int?,
      windSpeed: json['wind_speed'] is double?
          ? json['wind_speed']
          : json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'] as int?,
      windGust: json['wind_gust'] is double?
          ? json['wind_gust']
          : json['wind_gust'].toDouble(),
      weather: json['weather'] != null
          ? List<WeatherModel>.from(
              json['weather'].map((v) => WeatherModel.fromJson(v)))
          : null,
      pop: json['pop'] is double? ? json['pop'] : json['pop'].toDouble(),
    );
  }
}
