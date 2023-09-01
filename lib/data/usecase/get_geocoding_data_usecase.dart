import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/repository/get_geocoding_data_repository.dart';
import 'package:weather_forecast/domain/usecase/get_geocoding_data_usecase.dart';

class GetGeocodingDataUsecase implements IGetGeocodingDataUsecase {
  final IGetGeocodingDataRepository _getGeocodingDataRepository;

  GetGeocodingDataUsecase(
      {required IGetGeocodingDataRepository getGeocodingDataRepository})
      : _getGeocodingDataRepository = getGeocodingDataRepository;

  @override
  Future<GeocodingDataEntity> call({required String cityName}) =>
      _getGeocodingDataRepository(cityName: cityName);
}
