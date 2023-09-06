import 'package:weather_forecast/domain/shared/http_request_failure.dart';
import 'package:http/http.dart' as http;

class HttpRequestFailure implements IHttpRequestFailure {
  const HttpRequestFailure(this.object, this.stackTrace);
  final Object object;
  final StackTrace stackTrace;
}

class RequestFailure implements IHttpRequestFailure {
  const RequestFailure(this.response);
  final http.Response response;
}

class InvalidJsonDecodeFailure implements IHttpRequestFailure {
  const InvalidJsonDecodeFailure(this.body);
  final String body;
}

class FormattingFailure implements IHttpRequestFailure {
  const FormattingFailure(this.object, this.stackTrace);
  final Object object;
  final StackTrace stackTrace;
}
