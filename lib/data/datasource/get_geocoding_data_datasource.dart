import 'package:weather_forecast/domain/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';

class GetGeocodingDataDatasource implements IGetGeocodingDataDatasource {
  @override
  Future<GeocodingDataEntity> call({required String cityName}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
