import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';

abstract class IGetGeocodingDataUsecase {
  TaskEither<IHttpRequestFailure, GeocodingDataEntity> call(
      {required String cityName});
}
