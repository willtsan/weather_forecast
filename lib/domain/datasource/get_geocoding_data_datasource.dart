import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';

abstract class IGetGeocodingDataDatasource {
  TaskEither<IHttpRequestFailure, GeocodingDataEntity> call(
      {required String cityName});
}
