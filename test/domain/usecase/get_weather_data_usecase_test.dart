import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/data/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/data/models/weather_data_model.dart';
import 'package:weather_forecast/data/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/data/shared/http_request_failure.dart';
import 'package:weather_forecast/data/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/shared/http_request_failure.dart';

// Mock
class MockGetWeatherDataDatasource extends Mock
    implements GetWeatherDataDatasource {}

void main() {
  late final GetWeatherDataUsecase weatherDataUsecase;
  final Map<String, dynamic> jsonResponse = jsonDecode(
      '{"lat":-23.5507,"lon":-46.6334,"timezone":"America/Sao_Paulo","timezone_offset":-10800,"current":{"dt":1694011026,"sunrise":1693991578,"sunset":1694033847,"temp":18.4,"feels_like":18.46,"pressure":1028,"humidity":83,"dew_point":15.46,"uvi":8.75,"clouds":75,"visibility":10000,"wind_speed":6.69,"wind_deg":150,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}]},"daily":[{"dt":1694012400,"sunrise":1693991578,"sunset":1694033847,"moonrise":0,"moonset":1694007900,"moon_phase":0.75,"summary":"There will be partly cloudy today","temp":{"day":18.4,"min":15.4,"max":18.58,"night":16.05,"eve":16.58,"morn":15.53},"feels_like":{"day":18.46,"night":15.93,"eve":16.49,"morn":15.38},"pressure":1028,"humidity":83,"dew_point":15.46,"wind_speed":5.49,"wind_deg":140,"wind_gust":9.56,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":75,"pop":0.34,"uvi":8.75},{"dt":1694098800,"sunrise":1694077918,"sunset":1694120266,"moonrise":1694058960,"moonset":1694097240,"moon_phase":0.77,"summary":"There will be partly cloudy today","temp":{"day":23.05,"min":15.82,"max":26.2,"night":19.18,"eve":22.18,"morn":15.84},"feels_like":{"day":22.82,"night":19.19,"eve":22.15,"morn":15.7},"pressure":1021,"humidity":54,"dew_point":13.1,"wind_speed":4.53,"wind_deg":114,"wind_gust":8.63,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0.06,"uvi":8.8},{"dt":1694185200,"sunrise":1694164257,"sunset":1694206685,"moonrise":1694148780,"moonset":1694186760,"moon_phase":0.8,"summary":"You can expect partly cloudy in the morning, with clearing in the afternoon","temp":{"day":28.86,"min":17.44,"max":29.9,"night":22.21,"eve":25.51,"morn":17.44},"feels_like":{"day":27.65,"night":21.77,"eve":25.21,"morn":17.04},"pressure":1016,"humidity":28,"dew_point":8.9,"wind_speed":5.43,"wind_deg":355,"wind_gust":11.9,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":42,"pop":0,"uvi":9.17},{"dt":1694271600,"sunrise":1694250596,"sunset":1694293103,"moonrise":1694238300,"moonset":1694276460,"moon_phase":0.83,"summary":"There will be partly cloudy today","temp":{"day":30.21,"min":19.12,"max":31.43,"night":19.94,"eve":22.59,"morn":19.12},"feels_like":{"day":28.62,"night":19.79,"eve":22.5,"morn":18.47},"pressure":1015,"humidity":25,"dew_point":7.86,"wind_speed":4.89,"wind_deg":153,"wind_gust":6.52,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":74,"pop":0,"uvi":9.07},{"dt":1694358000,"sunrise":1694336935,"sunset":1694379521,"moonrise":1694327580,"moonset":1694366100,"moon_phase":0.86,"summary":"There will be partly cloudy today","temp":{"day":27.7,"min":17.47,"max":28.05,"night":20.7,"eve":21.92,"morn":18},"feels_like":{"day":27.07,"night":20.63,"eve":21.89,"morn":17.97},"pressure":1016,"humidity":34,"dew_point":10.09,"wind_speed":4.28,"wind_deg":149,"wind_gust":6.61,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":86,"pop":0.03,"uvi":2.58},{"dt":1694444400,"sunrise":1694423274,"sunset":1694465940,"moonrise":1694416440,"moonset":1694455800,"moon_phase":0.9,"summary":"There will be partly cloudy until morning, then clearing","temp":{"day":31.05,"min":18.36,"max":32.37,"night":25.49,"eve":28.09,"morn":18.36},"feels_like":{"day":29.39,"night":25.4,"eve":27.74,"morn":18.31},"pressure":1015,"humidity":25,"dew_point":8.45,"wind_speed":2.21,"wind_deg":128,"wind_gust":3.84,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3},{"dt":1694530800,"sunrise":1694509612,"sunset":1694552358,"moonrise":1694505120,"moonset":1694545440,"moon_phase":0.93,"summary":"There will be clear sky today","temp":{"day":32.61,"min":20.56,"max":34.32,"night":26.66,"eve":29.74,"morn":20.56},"feels_like":{"day":30.62,"night":26.66,"eve":28.51,"morn":20.03},"pressure":1012,"humidity":21,"dew_point":7.78,"wind_speed":2.89,"wind_deg":360,"wind_gust":6.38,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3},{"dt":1694617200,"sunrise":1694595950,"sunset":1694638776,"moonrise":1694593560,"moonset":1694634900,"moon_phase":0.96,"summary":"There will be clear sky today","temp":{"day":32.81,"min":20.55,"max":33.45,"night":21.49,"eve":24.63,"morn":20.55},"feels_like":{"day":30.69,"night":21.34,"eve":24.56,"morn":20.02},"pressure":1010,"humidity":19,"dew_point":5.9,"wind_speed":4.94,"wind_deg":146,"wind_gust":6.48,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3}]}');

  setUpAll(
    () {
      weatherDataUsecase = GetWeatherDataUsecase(
        getWeatherDataRepository: GetWeatherDataRepository(
          getWeatherDataDatasource: MockGetWeatherDataDatasource(),
        ),
      );

      when(() => weatherDataUsecase.call(lat: -23.5507, lon: -46.6334))
          .thenReturn(
        TaskEither.right(WeatherDataModel.fromJson(jsonResponse)),
      );

      when(() => weatherDataUsecase.call(lat: 0, lon: 0)).thenReturn(
        TaskEither.left(RequestFailure(Response('Request Failure', 500))),
      );
    },
  );

  test('get city weather', () async {
    weatherDataUsecase.call(lat: -23.5507, lon: -46.6334).run().then((value) {
      expect(value.getLeft(), const None());
      expect(value.getRight(), isA<Some<WeatherDataEntity>>());
    });
  });

  test('get request error', () async {
    weatherDataUsecase.call(lat: 0, lon: 0).run().then((value) {
      expect(value.getLeft(), isA<Some<IHttpRequestFailure>>());
      expect(value.getRight(), const None());
    });
  });
}
