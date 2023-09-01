import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/entities/geocoding_local_names_entity.dart';

class GeocodingDataModel extends GeocodingDataEntity {
  const GeocodingDataModel(
      {required super.name,
      required super.localNames,
      required super.lat,
      required super.lon,
      required super.country});

  factory GeocodingDataModel.fromJson(Map<String, dynamic> json) {
    return GeocodingDataModel(
      name: json['name'],
      localNames: json['local_names'] != null
          ? json['local_names']
              .map((x) => GeocodingLocalNamesEntity.fromJson(x))
          : <GeocodingLocalNamesEntity>[],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
    );
  }
}
