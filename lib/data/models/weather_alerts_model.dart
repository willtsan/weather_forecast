import 'package:weather_forecast/domain/entities/weather_alerts_entity.dart';

class WeatherAlertsModel extends WeatherAlertsEntity {
  const WeatherAlertsModel({
    required super.senderName,
    required super.event,
    required super.start,
    required super.end,
    required super.description,
    required super.tags,
  });

  factory WeatherAlertsModel.fromJson(Map<String, dynamic> json) {
    return WeatherAlertsModel(
      senderName: json['sender_name'] as String?,
      event: json['event'] as String?,
      start: json['start'] as int?,
      end: json['end'] as int?,
      description: json['description'] as String?,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'].map((v) => v as String))
          : null,
    );
  }
}
