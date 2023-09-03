import 'package:weather_forecast/domain/entities/weather_feels_like_entity.dart';

class WeatherFeelsLikeModel extends WeatherFeelsLikeEntity {
  const WeatherFeelsLikeModel({
    required super.day,
    required super.night,
    required super.eve,
    required super.morn,
  });

  factory WeatherFeelsLikeModel.fromJson(Map<String, dynamic> json) {
    return WeatherFeelsLikeModel(
      day: json['day'] is double? ? json['day'] : json['day'].toDouble,
      night: json['night'] is double? ? json['night'] : json['night'].toDouble,
      eve: json['eve'] is double? ? json['eve'] : json['eve'].toDouble,
      morn: json['morn'] is double? ? json['morn'] : json['morn'].toDouble,
    );
  }
}
