import 'package:weather_forecast/domain/entities/weather_data_entity.dart';

abstract class IGetWeatherDataUsecase {
  Future<WeatherDataEntity> call({required double lat, required double lon});
}
