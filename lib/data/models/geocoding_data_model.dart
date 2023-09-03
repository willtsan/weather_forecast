import 'package:weather_forecast/data/models/geocoding_local_names_model.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';

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
          ? GeocodingLocalNamesModel.fromJson(json['local_names'])
          : null,
      lat: json['lat'] is double? ? json['lat'] : json['lat'].toDouble(),
      lon: json['lon'] is double? ? json['lon'] : json['lon'].toDouble(),
      country: json['country'],
    );
  }
}
