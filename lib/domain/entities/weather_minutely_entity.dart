class WeatherMinutelyEntity {
  int? dt;
  int? precipitation;

  WeatherMinutelyEntity({dt, precipitation});

  WeatherMinutelyEntity.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    precipitation = json['precipitation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['precipitation'] = precipitation;
    return data;
  }
}
