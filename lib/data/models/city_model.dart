import 'package:weather_forecast/domain/entities/weather_data_entity.dart';

class CityModel {
  final String cityName;
  final WeatherDataEntity weather;

  CityModel({required this.cityName, required this.weather});
}
