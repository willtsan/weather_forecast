import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/domain/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/shared/http_request_failure.dart';
import 'package:weather_forecast/domain/repository/get_geocoding_data_repository.dart';

class GetGeocodingDataRepository implements IGetGeocodingDataRepository {
  final IGetGeocodingDataDatasource _getGeocodingDataDatasource;

  GetGeocodingDataRepository(
      {required IGetGeocodingDataDatasource getGeocodingDataDatasource})
      : _getGeocodingDataDatasource = getGeocodingDataDatasource;

  @override
  TaskEither<IHttpRequestFailure, List<GeocodingDataEntity>> call(
          {required String cityName}) =>
      _getGeocodingDataDatasource(cityName: cityName);
}
