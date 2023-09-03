import 'package:equatable/equatable.dart';

class WeatherMinutelyEntity extends Equatable {
  final int? dt;
  final int? precipitation;

  const WeatherMinutelyEntity({
    required this.dt,
    required this.precipitation,
  });

  @override
  List<Object?> get props => [dt, precipitation];
}
