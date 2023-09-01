class WeatherTempEntity {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  WeatherTempEntity({day, min, max, night, eve, morn});

  WeatherTempEntity.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}
