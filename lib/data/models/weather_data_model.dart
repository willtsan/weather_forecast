import 'package:weather_forecast/domain/entities/weather_alerts_entity.dart';
import 'package:weather_forecast/domain/entities/weather_current_entity.dart';
import 'package:weather_forecast/domain/entities/weather_daily_entity.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/entities/weather_hourly_entity.dart';
import 'package:weather_forecast/domain/entities/weather_minutely_entity.dart';

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
      alerts: json['alerts']
          ? json['alerts'].map((x) => WeatherAlertsEntity.fromJson(x))
          : <WeatherAlertsEntity>[],
      current: json['current'] != null
          ? WeatherCurrentEntity.fromJson(json['current'])
          : null,
      daily: json['daily']
          ? json['daily'].map((x) => WeatherDailyEntity.fromJson(x))
          : <WeatherDailyEntity>[],
      hourly: json['hourly']
          ? json['hourly'].map((x) => WeatherHourlyEntity.fromJson(x))
          : <WeatherHourlyEntity>[],
      lat: json['lat'],
      lon: json['lon'],
      minutely: json['minutely']
          ? json['minutely'].map((x) => WeatherMinutelyEntity.fromJson(x))
          : <WeatherMinutelyEntity>[],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
    );
  }
}
