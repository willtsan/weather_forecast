import 'package:weather_forecast/domain/entities/weather_minutely_entity.dart';

class WeatherMinutelyModel extends WeatherMinutelyEntity {
  const WeatherMinutelyModel({
    required super.dt,
    required super.precipitation,
  });

  factory WeatherMinutelyModel.fromJson(Map<String, dynamic> json) {
    return WeatherMinutelyModel(
      dt: json['dt'] as int?,
      precipitation: json['precipitation'] as int?,
    );
  }
}
