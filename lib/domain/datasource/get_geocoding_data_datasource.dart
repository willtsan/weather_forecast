import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';

abstract class IGetGeocodingDataDatasource {
  Future<GeocodingDataEntity> call({required String cityName});
}
