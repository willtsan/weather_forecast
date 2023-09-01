import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';

abstract class IGetGeocodingDataUsecase {
  Future<GeocodingDataEntity> call({required String cityName});
}
