import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/data/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/data/models/geocoding_data_model.dart';
import 'package:weather_forecast/data/repository/get_geocoding_data_repository.dart';
import 'package:weather_forecast/data/shared/http_request_failure.dart';
import 'package:weather_forecast/data/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/shared/http_request_failure.dart';

// Mock
class MockGetGeocodingDatasource extends Mock
    implements GetGeocodingDataDatasource {}

void main() {
  late final GetGeocodingDataUsecase geocodingDataUsecase;
  final jsonResponse = jsonDecode(
      '[{"name":"São Paulo","local_names":{"es":"San Pablo","yi":"סאו פאולא","he":"סאו פאולו","ar":"ساو باولو","hi":"साओ पाउलो","fr":"São Paulo","io":"Sao Paulo","ug":"San Pawlo","bn":"সাঁউ পাউলু","lv":"Sanpaulu","ta":"சாவோ பாவுலோ","yo":"Sao Paulo","ne":"साओ पाउलो","el":"Σάο Πάολο","gl":"San Paulo","mr":"साओ पाउलो","sh":"Sao Paulo","ko":"상파울루","en":"São Paulo","kk":"Сан-Паулу","sa":"साओ पाओलो","ka":"სან-პაულუ","ay":"San Pauluw","no":"São Paulo","oc":"São Paulo","sr":"Сао Пауло","am":"ሳው ፓውሉ","tr":"Сан Паулу","la":"Paulopolis","be":"Сан-Паўлу","ba":"Сан-Паулу","pl":"São Paulo","eo":"San-Paŭlo","mn":"Сан-Паулу","pa":"ਸਾਓ ਪਾਓਲੋ","kn":"ಸಾವೊ ಪೌಲೊ","it":"San Paolo","ml":"സാവോ പോളോ","hy":"Սան Պաուլո","nl":"São Paulo","tg":"Сан-Паулу","cv":"Сан-Паулу","de":"São Paulo","ja":"サンパウロ","bg":"Сао Пауло","th":"เซาเปาลู","mk":"Сао Паоло","sv":"São Paulo","ab":"Сан-Паулу","pt":"São Paulo","wa":"Sawo Pålo","dv":"ސައޮ ޕައުލޯ","tt":"Сан-Паулу","uz":"San-Paulu","zh":"聖保羅","kv":"Сан-Паулу","fa":"سائوپائولو","lt":"San Paulas","az":"San Paulo","uk":"Сан-Паулу","ru":"Сан-Паулу","tk":"San-Paulu","ur":"ساؤ پالو","os":"Сан-Паулу","ce":"Сан-Паулу"},"lat":-23.5506507,"lon":-46.6333824,"country":"BR","state":"São Paulo"},{"name":"Sao Paulo","lat":-29.1298857,"lon":-51.9879887,"country":"BR","state":"Rio Grande do Sul"},{"name":"Sao Paulo","local_names":{"ar":"ساو بولو","en":"Sao Paulo"},"lat":25.205073900000002,"lon":55.169630528331346,"country":"AE","state":"Dubai"},{"name":"São Paulo","lat":-8.8135247,"lon":13.2559223,"country":"AO","state":"Luanda Province"},{"name":"São Paulo","lat":-20.060231950000002,"lon":-42.848429026453715,"country":"BR","state":"Minas Gerais"}]');

  setUpAll(
    () {
      geocodingDataUsecase = GetGeocodingDataUsecase(
        getGeocodingDataRepository: GetGeocodingDataRepository(
          getGeocodingDataDatasource: MockGetGeocodingDatasource(),
        ),
      );

      when(() => geocodingDataUsecase.call(cityName: 'Sao Paulo')).thenReturn(
        TaskEither.right(
          List.from(
            jsonResponse.map(
              (x) => GeocodingDataModel.fromJson(x),
            ),
          ),
        ),
      );

      when(() => geocodingDataUsecase.call(cityName: 'abcde')).thenReturn(
        TaskEither.left(RequestFailure(Response('Request Failure', 500))),
      );
    },
  );

  test('get city latitude and longitude', () async {
    geocodingDataUsecase(cityName: 'Sao Paulo').run().then((value) {
      expect(value.getLeft(), const None());
      expect(value.getRight(), isA<Some<List<GeocodingDataEntity>>>());
    });
  });

  test('get request error', () async {
    geocodingDataUsecase(cityName: 'abcde').run().then((value) {
      expect(value.getLeft(), isA<Some<IHttpRequestFailure>>());
      expect(value.getRight(), const None());
    });
  });
}
