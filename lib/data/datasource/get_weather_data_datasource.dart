import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast/data/shared/http_request_failure.dart';
import 'package:weather_forecast/data/models/weather_data_model.dart';
import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/shared/http_request_failure.dart';
import 'package:weather_forecast/env/env.dart';

class GetWeatherDataDatasource implements IGetWeatherDataDatasource {
  final http.Client _httpClient;

  GetWeatherDataDatasource({required http.Client httpClient})
      : _httpClient = httpClient;

  @override
  TaskEither<IHttpRequestFailure, WeatherDataEntity> call(
          {required double lat, required double lon}) =>
      TaskEither<IHttpRequestFailure, http.Response>.tryCatch(
        () => _httpClient.get(
          Uri.https(
            Env.baseWeatherUrl,
            '/data/3.0/onecall',
            {
              'lat': lat.toString(),
              'lon': lon.toString(),
              'units': 'metric',
              'exclude': 'minutely,hourly,alerts',
              'appid': Env.openWeatherKey,
            },
          ),
        ),
        HttpRequestFailure.new,
      ).chainEither(
        (response) => Either.Do(
          (_) {
            final body = _(
              _validResponseBody(response, RequestFailure.new),
            );

            final json = _(
              Either.tryCatch(
                () => jsonDecode(body),
                (_, __) => InvalidJsonDecodeFailure(body),
              ),
            );

            return _(
              Either.tryCatch(
                () => WeatherDataModel.fromJson(json as Map<String, dynamic>),
                FormattingFailure.new,
              ),
            );
          },
        ),
      );

  Either<E, String> _validResponseBody<E>(
    http.Response response,
    E Function(http.Response) onError,
  ) =>
      Either<E, http.Response>.fromPredicate(
        response,
        (r) => r.statusCode == 200,
        onError,
      ).map(
        (r) => r.body,
      );
}
