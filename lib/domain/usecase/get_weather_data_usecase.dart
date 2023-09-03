import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';

abstract class IGetWeatherDataUsecase {
  TaskEither<IHttpRequestFailure, WeatherDataEntity> call(
      {required double lat, required double lon});
}
