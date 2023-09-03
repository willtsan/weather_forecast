import 'package:weather_forecast/domain/entities/weather_temp_entity.dart';

class WeatherTempModel extends WeatherTempEntity {
  const WeatherTempModel({
    required super.day,
    required super.min,
    required super.max,
    required super.night,
    required super.eve,
    required super.morn,
  });

  factory WeatherTempModel.fromJson(Map<String, dynamic> json) {
    return WeatherTempModel(
      day: json['day'] is double? ? json['day'] : json['day'].toDouble(),
      min: json['min'] is double? ? json['min'] : json['min'].toDouble(),
      max: json['max'] is double? ? json['max'] : json['max'].toDouble(),
      night:
          json['night'] is double? ? json['night'] : json['night'].toDouble(),
      eve: json['eve'] is double? ? json['eve'] : json['eve'].toDouble(),
      morn: json['morn'] is double? ? json['morn'] : json['morn'].toDouble(),
    );
  }
}
