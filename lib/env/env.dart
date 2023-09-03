import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class Env {
  @EnviedField(varName: 'OPEN_WEATHER_KEY', obfuscate: true)
  static String openWeatherKey = _Env.openWeatherKey;
  @EnviedField(varName: 'BASE_WEATHER_URL', obfuscate: true)
  static String baseWeatherUrl = _Env.baseWeatherUrl;
}
