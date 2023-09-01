import 'package:weather_forecast/domain/entities/weather_entity.dart';
import 'package:weather_forecast/domain/entities/weather_feels_like_entity.dart';
import 'package:weather_forecast/domain/entities/weather_temp_entity.dart';

class WeatherDailyEntity {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  String? summary;
  WeatherTempEntity? temp;
  WeatherFeelsLikeEntity? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  List<WeatherEntity>? weather;
  int? clouds;
  double? pop;
  double? rain;
  double? uvi;

  WeatherDailyEntity(
      {dt,
      sunrise,
      sunset,
      moonrise,
      moonset,
      moonPhase,
      summary,
      temp,
      feelsLike,
      pressure,
      humidity,
      dewPoint,
      windSpeed,
      windDeg,
      windGust,
      weather,
      clouds,
      pop,
      rain,
      uvi});

  WeatherDailyEntity.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    summary = json['summary'];
    temp =
        json['temp'] != null ? WeatherTempEntity.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? WeatherFeelsLikeEntity.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = <WeatherEntity>[];
      json['weather'].forEach((v) {
        weather!.add(WeatherEntity.fromJson(v));
      });
    }
    clouds = json['clouds'];
    pop = json['pop'];
    rain = json['rain'];
    uvi = json['uvi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    data['summary'] = summary;
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    if (feelsLike != null) {
      data['feels_like'] = feelsLike!.toJson();
    }
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['wind_speed'] = windSpeed;
    data['wind_deg'] = windDeg;
    data['wind_gust'] = windGust;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['clouds'] = clouds;
    data['pop'] = pop;
    data['rain'] = rain;
    data['uvi'] = uvi;
    return data;
  }
}
