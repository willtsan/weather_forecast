import 'package:weather_forecast/data/models/weather_feels_like_model.dart';
import 'package:weather_forecast/data/models/weather_model.dart';
import 'package:weather_forecast/data/models/weather_temp_model.dart';
import 'package:weather_forecast/domain/entities/weather_daily_entity.dart';

class WeatherDailyModel extends WeatherDailyEntity {
  WeatherDailyModel(
      {required super.dt,
      required super.sunrise,
      required super.sunset,
      required super.moonrise,
      required super.moonset,
      required super.moonPhase,
      required super.summary,
      required super.temp,
      required super.feelsLike,
      required super.pressure,
      required super.humidity,
      required super.dewPoint,
      required super.windSpeed,
      required super.windDeg,
      required super.windGust,
      required super.weather,
      required super.clouds,
      required super.pop,
      required super.rain,
      required super.uvi});

  factory WeatherDailyModel.fromJson(Map<String, dynamic> json) {
    return WeatherDailyModel(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'] is double?
          ? json['moon_phase']
          : json['moon_phase'].toDouble(),
      summary: json['summary'],
      temp:
          json['temp'] != null ? WeatherTempModel.fromJson(json['temp']) : null,
      feelsLike: json['feels_like'] != null
          ? WeatherFeelsLikeModel.fromJson(json['feels_like'])
          : null,
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'] is double?
          ? json['dew_point']
          : json['dew_point'].toDouble(),
      windSpeed: json['wind_speed'] is double?
          ? json['wind_speed']
          : json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'] is double?
          ? json['wind_gust']
          : json['wind_gust'].toDouble(),
      weather: json['weather'] != null
          ? List<WeatherModel>.from(
              json['weather'].map((v) => WeatherModel.fromJson(v)))
          : null,
      clouds: json['clouds'],
      pop: json['pop'] is double? ? json['pop'] : json['pop'].toDouble(),
      rain: json['rain'] is double? ? json['rain'] : json['rain'].toDouble(),
      uvi: json['uvi'] is double? ? json['uvi'] : json['uvi'].toDouble(),
    );
  }
}
