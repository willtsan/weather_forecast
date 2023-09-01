import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/shared/base.controller.dart';

class HomeController extends BaseController {
  final IGetWeatherDataUsecase _getWeatherDataUsecase;

  HomeController({required IGetWeatherDataUsecase getWeatherDataUsecase})
      : _getWeatherDataUsecase = getWeatherDataUsecase;
}
