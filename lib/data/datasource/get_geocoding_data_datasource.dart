import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/data/http_request_failure.dart';
import 'package:weather_forecast/data/models/geocoding_data_model.dart';
import 'package:weather_forecast/domain/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/http_request_failure.dart';
import 'package:weather_forecast/env/env.dart';

class GetGeocodingDataDatasource implements IGetGeocodingDataDatasource {
  final http.Client _httpClient;

  GetGeocodingDataDatasource({required http.Client httpClient})
      : _httpClient = httpClient;

  @override
  TaskEither<IHttpRequestFailure, GeocodingDataEntity> call(
          {required String cityName}) =>
      TaskEither<IHttpRequestFailure, http.Response>.tryCatch(
        () => _httpClient.get(
          Uri.https(
            Env.baseWeatherUrl,
            '/geo/1.0/direct',
            {
              'q': cityName,
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
                () => GeocodingDataModel.fromJson(
                    json.first as Map<String, dynamic>),
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
