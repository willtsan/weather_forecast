import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';
import 'package:weather_forecast/domain/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';

class GetWeatherDataUsecase implements IGetWeatherDataUsecase {
  final IGetWeatherDataRepository _getWeatherDataRepository;

  GetWeatherDataUsecase(
      {required IGetWeatherDataRepository getWeatherDataRepository})
      : _getWeatherDataRepository = getWeatherDataRepository;

  @override
  TaskEither<IHttpRequestFailure, WeatherDataEntity> call(
          {required double lat, required double lon}) =>
      _getWeatherDataRepository(lat: lat, lon: lon);
}
