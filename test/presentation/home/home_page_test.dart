import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_forecast/data/models/geocoding_data_model.dart';
import 'package:weather_forecast/data/models/weather_data_model.dart';
import 'package:weather_forecast/data/repository/get_geocoding_data_repository.dart';
import 'package:weather_forecast/data/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/data/shared/http_request_failure.dart';
import 'package:weather_forecast/data/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/data/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/domain/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/shared/http_request_failure.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/presentation/home/home_controller.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/presentation/home/home_page.dart';

class MockGetWeatherDataDatasource extends Mock
    implements IGetWeatherDataDatasource {
  final Map<String, dynamic> jsonResponseWeather = jsonDecode(
      '{"lat":-23.5507,"lon":-46.6334,"timezone":"America/Sao_Paulo","timezone_offset":-10800,"current":{"dt":1694011026,"sunrise":1693991578,"sunset":1694033847,"temp":18.4,"feels_like":18.46,"pressure":1028,"humidity":83,"dew_point":15.46,"uvi":8.75,"clouds":75,"visibility":10000,"wind_speed":6.69,"wind_deg":150,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}]},"daily":[{"dt":1694012400,"sunrise":1693991578,"sunset":1694033847,"moonrise":0,"moonset":1694007900,"moon_phase":0.75,"summary":"There will be partly cloudy today","temp":{"day":18.4,"min":15.4,"max":18.58,"night":16.05,"eve":16.58,"morn":15.53},"feels_like":{"day":18.46,"night":15.93,"eve":16.49,"morn":15.38},"pressure":1028,"humidity":83,"dew_point":15.46,"wind_speed":5.49,"wind_deg":140,"wind_gust":9.56,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":75,"pop":0.34,"uvi":8.75},{"dt":1694098800,"sunrise":1694077918,"sunset":1694120266,"moonrise":1694058960,"moonset":1694097240,"moon_phase":0.77,"summary":"There will be partly cloudy today","temp":{"day":23.05,"min":15.82,"max":26.2,"night":19.18,"eve":22.18,"morn":15.84},"feels_like":{"day":22.82,"night":19.19,"eve":22.15,"morn":15.7},"pressure":1021,"humidity":54,"dew_point":13.1,"wind_speed":4.53,"wind_deg":114,"wind_gust":8.63,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0.06,"uvi":8.8},{"dt":1694185200,"sunrise":1694164257,"sunset":1694206685,"moonrise":1694148780,"moonset":1694186760,"moon_phase":0.8,"summary":"You can expect partly cloudy in the morning, with clearing in the afternoon","temp":{"day":28.86,"min":17.44,"max":29.9,"night":22.21,"eve":25.51,"morn":17.44},"feels_like":{"day":27.65,"night":21.77,"eve":25.21,"morn":17.04},"pressure":1016,"humidity":28,"dew_point":8.9,"wind_speed":5.43,"wind_deg":355,"wind_gust":11.9,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":42,"pop":0,"uvi":9.17},{"dt":1694271600,"sunrise":1694250596,"sunset":1694293103,"moonrise":1694238300,"moonset":1694276460,"moon_phase":0.83,"summary":"There will be partly cloudy today","temp":{"day":30.21,"min":19.12,"max":31.43,"night":19.94,"eve":22.59,"morn":19.12},"feels_like":{"day":28.62,"night":19.79,"eve":22.5,"morn":18.47},"pressure":1015,"humidity":25,"dew_point":7.86,"wind_speed":4.89,"wind_deg":153,"wind_gust":6.52,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":74,"pop":0,"uvi":9.07},{"dt":1694358000,"sunrise":1694336935,"sunset":1694379521,"moonrise":1694327580,"moonset":1694366100,"moon_phase":0.86,"summary":"There will be partly cloudy today","temp":{"day":27.7,"min":17.47,"max":28.05,"night":20.7,"eve":21.92,"morn":18},"feels_like":{"day":27.07,"night":20.63,"eve":21.89,"morn":17.97},"pressure":1016,"humidity":34,"dew_point":10.09,"wind_speed":4.28,"wind_deg":149,"wind_gust":6.61,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":86,"pop":0.03,"uvi":2.58},{"dt":1694444400,"sunrise":1694423274,"sunset":1694465940,"moonrise":1694416440,"moonset":1694455800,"moon_phase":0.9,"summary":"There will be partly cloudy until morning, then clearing","temp":{"day":31.05,"min":18.36,"max":32.37,"night":25.49,"eve":28.09,"morn":18.36},"feels_like":{"day":29.39,"night":25.4,"eve":27.74,"morn":18.31},"pressure":1015,"humidity":25,"dew_point":8.45,"wind_speed":2.21,"wind_deg":128,"wind_gust":3.84,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3},{"dt":1694530800,"sunrise":1694509612,"sunset":1694552358,"moonrise":1694505120,"moonset":1694545440,"moon_phase":0.93,"summary":"There will be clear sky today","temp":{"day":32.61,"min":20.56,"max":34.32,"night":26.66,"eve":29.74,"morn":20.56},"feels_like":{"day":30.62,"night":26.66,"eve":28.51,"morn":20.03},"pressure":1012,"humidity":21,"dew_point":7.78,"wind_speed":2.89,"wind_deg":360,"wind_gust":6.38,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3},{"dt":1694617200,"sunrise":1694595950,"sunset":1694638776,"moonrise":1694593560,"moonset":1694634900,"moon_phase":0.96,"summary":"There will be clear sky today","temp":{"day":32.81,"min":20.55,"max":33.45,"night":21.49,"eve":24.63,"morn":20.55},"feels_like":{"day":30.69,"night":21.34,"eve":24.56,"morn":20.02},"pressure":1010,"humidity":19,"dew_point":5.9,"wind_speed":4.94,"wind_deg":146,"wind_gust":6.48,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":0,"pop":0,"uvi":3}]}');

  @override
  TaskEither<IHttpRequestFailure, WeatherDataEntity> call(
      {required double lat, required double lon}) {
    return TaskEither.right(WeatherDataModel.fromJson(jsonResponseWeather));
  }
}

class MockGetGeocodingDatasource extends Mock
    implements IGetGeocodingDataDatasource {
  final jsonResponseGeocoding = jsonDecode(
      '[{"name":"São Paulo","local_names":{"es":"San Pablo","yi":"סאו פאולא","he":"סאו פאולו","ar":"ساو باولو","hi":"साओ पाउलो","fr":"São Paulo","io":"Sao Paulo","ug":"San Pawlo","bn":"সাঁউ পাউলু","lv":"Sanpaulu","ta":"சாவோ பாவுலோ","yo":"Sao Paulo","ne":"साओ पाउलो","el":"Σάο Πάολο","gl":"San Paulo","mr":"साओ पाउलो","sh":"Sao Paulo","ko":"상파울루","en":"São Paulo","kk":"Сан-Паулу","sa":"साओ पाओलो","ka":"სან-პაულუ","ay":"San Pauluw","no":"São Paulo","oc":"São Paulo","sr":"Сао Пауло","am":"ሳው ፓውሉ","tr":"Сан Паулу","la":"Paulopolis","be":"Сан-Паўлу","ba":"Сан-Паулу","pl":"São Paulo","eo":"San-Paŭlo","mn":"Сан-Паулу","pa":"ਸਾਓ ਪਾਓਲੋ","kn":"ಸಾವೊ ಪೌಲೊ","it":"San Paolo","ml":"സാവോ പോളോ","hy":"Սան Պաուլո","nl":"São Paulo","tg":"Сан-Паулу","cv":"Сан-Паулу","de":"São Paulo","ja":"サンパウロ","bg":"Сао Пауло","th":"เซาเปาลู","mk":"Сао Паоло","sv":"São Paulo","ab":"Сан-Паулу","pt":"São Paulo","wa":"Sawo Pålo","dv":"ސައޮ ޕައުލޯ","tt":"Сан-Паулу","uz":"San-Paulu","zh":"聖保羅","kv":"Сан-Паулу","fa":"سائوپائولو","lt":"San Paulas","az":"San Paulo","uk":"Сан-Паулу","ru":"Сан-Паулу","tk":"San-Paulu","ur":"ساؤ پالو","os":"Сан-Паулу","ce":"Сан-Паулу"},"lat":-23.5506507,"lon":-46.6333824,"country":"BR","state":"São Paulo"},{"name":"Sao Paulo","lat":-29.1298857,"lon":-51.9879887,"country":"BR","state":"Rio Grande do Sul"},{"name":"Sao Paulo","local_names":{"ar":"ساو بولو","en":"Sao Paulo"},"lat":25.205073900000002,"lon":55.169630528331346,"country":"AE","state":"Dubai"},{"name":"São Paulo","lat":-8.8135247,"lon":13.2559223,"country":"AO","state":"Luanda Province"},{"name":"São Paulo","lat":-20.060231950000002,"lon":-42.848429026453715,"country":"BR","state":"Minas Gerais"}]');

  @override
  TaskEither<IHttpRequestFailure, List<GeocodingDataEntity>> call(
      {required String cityName}) {
    if (cityName == 'Sao Paulo') {
      return TaskEither.right(
        List.from(
          jsonResponseGeocoding.map(
            (x) => GeocodingDataModel.fromJson(x),
          ),
        ),
      );
    } else {
      return TaskEither.left(
          RequestFailure(http.Response('Request Failure', 500)));
    }
  }
}

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late GetMaterialApp app;
  late final HomeController homeController;
  late final GetGeocodingDataUsecase geocodingDataUsecase;
  late final GetWeatherDataUsecase weatherDataUsecase;
  final MockInternetConnection mockInternetConnection =
      MockInternetConnection();

  setUpAll(() {
    geocodingDataUsecase = GetGeocodingDataUsecase(
      getGeocodingDataRepository: GetGeocodingDataRepository(
        getGeocodingDataDatasource: MockGetGeocodingDatasource(),
      ),
    );

    weatherDataUsecase = GetWeatherDataUsecase(
      getWeatherDataRepository: GetWeatherDataRepository(
        getWeatherDataDatasource: MockGetWeatherDataDatasource(),
      ),
    );

    Get.lazyPut<IGetGeocodingDataUsecase>(() => geocodingDataUsecase,
        fenix: true);
    Get.lazyPut<IGetWeatherDataUsecase>(() => weatherDataUsecase, fenix: true);

    when(() => mockInternetConnection.internetStatus)
        .thenAnswer((invocation) => Future.value(InternetStatus.connected));
    when(() => mockInternetConnection.onStatusChange)
        .thenAnswer((invocation) => Stream.value(InternetStatus.connected));

    homeController = HomeController(
        getWeatherDataUsecase: weatherDataUsecase,
        geocodingDataUsecase: geocodingDataUsecase,
        internetConnection: mockInternetConnection);

    Get.lazyPut<HomeController>(() => homeController, fenix: true);
  });

  setUp(() {
    app = GetMaterialApp(
      routes: {
        '/home': (_) => HomePage(),
        '/details': (_) => Container(),
      },
      initialRoute: '/home',
    );
  });

  testWidgets(
    'Test build widgets',
    (tester) async {
      await tester.pumpWidget(app);

      var clearButton = find.byKey(const Key('clear_button'));
      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var emptyCitiesMessage = find.byKey(const Key('empty_cities_message'));

      expect(clearButton, findsNothing);
      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);
      expect(emptyCitiesMessage, findsOneWidget);
    },
  );

  testWidgets(
    'Search city and return weather data',
    (tester) async {
      await tester.pumpWidget(app);

      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var citiesList = find.byKey(const Key('cities_list'));
      var errorMessage = find.byKey(const Key('error_message'));
      var cityResult = find.byKey(const Key('city_0'));

      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.tap(searchField);
      await tester.pumpAndSettle();

      await tester.enterText(searchField, 'Sao Paulo');
      await tester.pumpAndSettle();

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsOneWidget);
      expect(errorMessage, findsNothing);

      expect(cityResult, findsOneWidget);
    },
  );

  testWidgets(
    'Search city and return a error',
    (tester) async {
      await tester.pumpWidget(app);

      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var citiesList = find.byKey(const Key('cities_list'));
      var errorMessage = find.byKey(const Key('error_message'));
      var tryAgainButton = find.byKey(const Key("try_again_button"));

      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.tap(searchField);
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(searchField, 'abcde');
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsNothing);
      expect(errorMessage, findsOneWidget);

      expect(tryAgainButton, findsOneWidget);

      await tester.tap(tryAgainButton);
      await tester.pump(const Duration(seconds: 1));
    },
  );

  testWidgets(
    'Search city, return error, tap try again and search a valid city',
    (tester) async {
      await tester.pumpWidget(app);

      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var citiesList = find.byKey(const Key('cities_list'));
      var errorMessage = find.byKey(const Key('error_message'));
      var tryAgainButton = find.byKey(const Key('try_again_button'));
      var cityResult = find.byKey(const Key('city_0'));

      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.tap(searchField);
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(searchField, 'abcde');
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsNothing);
      expect(errorMessage, findsOneWidget);
      expect(tryAgainButton, findsOneWidget);

      await tester.tap(tryAgainButton);
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(searchField, 'Sao Paulo');
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsOneWidget);
      expect(errorMessage, findsNothing);

      expect(cityResult, findsOneWidget);
    },
  );

  testWidgets(
    'Search city, return weather data then tap clear button',
    (tester) async {
      await tester.pumpWidget(app);

      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var citiesList = find.byKey(const Key('cities_list'));
      var errorMessage = find.byKey(const Key('error_message'));
      var cityResult = find.byKey(const Key('city_0'));
      var clearButton = find.byKey(const Key("clear_button"));
      var emptyCitiesMessage = find.byKey(const Key('empty_cities_message'));

      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.enterText(searchField, 'Sao Paulo');
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsOneWidget);
      expect(errorMessage, findsNothing);

      expect(cityResult, findsOneWidget);

      expect(clearButton, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump(const Duration(seconds: 1));

      expect(emptyCitiesMessage, findsOneWidget);
    },
  );

  testWidgets(
    'Search city, return weather data and tap in result',
    (tester) async {
      await tester.pumpWidget(app);

      var searchField = find.byKey(const Key('search_field'));
      var searchButton = find.byKey(const Key('search_button'));
      var citiesList = find.byKey(const Key('cities_list'));
      var errorMessage = find.byKey(const Key('error_message'));
      var cityResult = find.byKey(const Key('city_0'));
      expect(searchField, findsOneWidget);
      expect(searchButton, findsOneWidget);

      await tester.enterText(searchField, 'Sao Paulo');
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(searchButton);
      await tester.pump(const Duration(seconds: 1));

      expect(citiesList, findsOneWidget);
      expect(errorMessage, findsNothing);

      expect(cityResult, findsOneWidget);

      await tester.tap(cityResult);
      await tester.pump(const Duration(seconds: 1));

      expect(Get.currentRoute, '/details');
    },
  );
}
