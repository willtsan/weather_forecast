import 'package:equatable/equatable.dart';

class WeatherAlertsEntity extends Equatable {
  final String? senderName;
  final String? event;
  final int? start;
  final int? end;
  final String? description;
  final List<String>? tags;

  const WeatherAlertsEntity({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        senderName,
        event,
        start,
        end,
        description,
        tags,
      ];
}
