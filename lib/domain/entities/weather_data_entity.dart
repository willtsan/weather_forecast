import 'package:equatable/equatable.dart';
import 'package:weather_forecast/domain/entities/weather_alerts_entity.dart';
import 'package:weather_forecast/domain/entities/weather_current_entity.dart';
import 'package:weather_forecast/domain/entities/weather_daily_entity.dart';
import 'package:weather_forecast/domain/entities/weather_hourly_entity.dart';
import 'package:weather_forecast/domain/entities/weather_minutely_entity.dart';

class WeatherDataEntity extends Equatable {
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final WeatherCurrentEntity? current;
  final List<WeatherMinutelyEntity>? minutely;
  final List<WeatherHourlyEntity>? hourly;
  final List<WeatherDailyEntity>? daily;
  final List<WeatherAlertsEntity>? alerts;

  const WeatherDataEntity({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  @override
  List<Object?> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        current,
        minutely,
        hourly,
        daily,
        alerts
      ];
}
