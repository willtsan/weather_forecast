import 'package:weather_forecast/data/models/weather_alerts_model.dart';
import 'package:weather_forecast/data/models/weather_current_model.dart';
import 'package:weather_forecast/data/models/weather_daily_model.dart';
import 'package:weather_forecast/data/models/weather_hourly_model.dart';
import 'package:weather_forecast/data/models/weather_minutely_model.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';

class WeatherDataModel extends WeatherDataEntity {
  const WeatherDataModel(
      {required super.lat,
      required super.lon,
      required super.timezone,
      required super.timezoneOffset,
      required super.current,
      required super.minutely,
      required super.hourly,
      required super.daily,
      required super.alerts});

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      alerts: json['alerts'] != null
          ? List.from(json['alerts'].map((x) => WeatherAlertsModel.fromJson(x)))
          : <WeatherAlertsModel>[],
      current: json['current'] != null
          ? WeatherCurrentModel.fromJson(json['current'])
          : null,
      daily: json['daily'] != null
          ? List.from(json['daily'].map((x) => WeatherDailyModel.fromJson(x)))
          : <WeatherDailyModel>[],
      hourly: json['hourly'] != null
          ? List.from(json['hourly'].map((x) => WeatherHourlyModel.fromJson(x)))
          : <WeatherHourlyModel>[],
      lat: json['lat'] is double? ? json['lat'] : json['lat'].toDouble(),
      lon: json['lon'] is double? ? json['lon'] : json['lon'].toDouble(),
      minutely: json['minutely'] != null
          ? List.from(
              json['minutely'].map((x) => WeatherMinutelyModel.fromJson(x)))
          : <WeatherMinutelyModel>[],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
    );
  }
}
