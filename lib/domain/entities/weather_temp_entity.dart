import 'package:equatable/equatable.dart';

class WeatherTempEntity extends Equatable {
  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  const WeatherTempEntity({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  @override
  List<Object?> get props => [day, min, max, night, eve, morn];
}
