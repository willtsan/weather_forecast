import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';

class GetWeatherDataDatasource implements IGetWeatherDataDatasource {
  @override
  Future<WeatherDataEntity> call({required double lat, required double lon}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
