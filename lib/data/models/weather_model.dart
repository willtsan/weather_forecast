import 'package:weather_forecast/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}
