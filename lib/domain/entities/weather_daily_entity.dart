import 'package:equatable/equatable.dart';
import 'package:weather_forecast/domain/entities/weather_entity.dart';
import 'package:weather_forecast/domain/entities/weather_feels_like_entity.dart';
import 'package:weather_forecast/domain/entities/weather_temp_entity.dart';

class WeatherDailyEntity extends Equatable {
  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;
  final String? summary;
  final WeatherTempEntity? temp;
  final WeatherFeelsLikeEntity? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<WeatherEntity>? weather;
  final int? clouds;
  final double? pop;
  final double? rain;
  final double? uvi;

  const WeatherDailyEntity({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  @override
  List<Object?> get props => [
        dt,
        sunrise,
        sunset,
        moonrise,
        moonset,
        moonPhase,
        summary,
        temp,
        feelsLike,
        pressure,
        humidity,
        dewPoint,
        windSpeed,
        windDeg,
        windGust,
        weather,
        clouds,
        pop,
        rain,
        uvi
      ];
}
