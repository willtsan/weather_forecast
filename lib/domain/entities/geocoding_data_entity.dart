import 'package:equatable/equatable.dart';

import 'geocoding_local_names_entity.dart';

class GeocodingDataEntity extends Equatable {
  final String? name;
  final GeocodingLocalNamesEntity? localNames;
  final double? lat;
  final double? lon;
  final String? country;

  const GeocodingDataEntity({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
  });

  @override
  List<Object?> get props => [name, localNames, lat, lon, country];
}
