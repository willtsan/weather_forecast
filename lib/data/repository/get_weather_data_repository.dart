import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';
import 'package:weather_forecast/domain/repository/get_weather_data_repository.dart';

class GetWeatherDataRepository implements IGetWeatherDataRepository {
  final IGetWeatherDataDatasource _getWeatherDataDatasource;

  GetWeatherDataRepository(
      {required IGetWeatherDataDatasource getWeatherDataDatasource})
      : _getWeatherDataDatasource = getWeatherDataDatasource;

  @override
  TaskEither<IHttpRequestFailure, WeatherDataEntity> call(
          {required double lat, required double lon}) =>
      _getWeatherDataDatasource(lat: lat, lon: lon);
}
