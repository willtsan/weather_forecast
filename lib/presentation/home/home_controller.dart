import 'package:weather_forecast/domain/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/shared/base.controller.dart';

class HomeController extends BaseController {
  final IGetWeatherDataUsecase _getWeatherDataUsecase;
  final IGetGeocodingDataUsecase _geocodingDataUsecase;

  HomeController(
      {required IGetWeatherDataUsecase getWeatherDataUsecase,
      required IGetGeocodingDataUsecase geocodingDataUsecase})
      : _getWeatherDataUsecase = getWeatherDataUsecase,
        _geocodingDataUsecase = geocodingDataUsecase;

  void fetchData() {
    // final request = _getWeatherDataUsecase(lat: 33.44, lon: -94.04)
    //     .run()
    //     .then((value) => value.fold((l) => print(l), (r) => print(r)));

    final geo_request = _geocodingDataUsecase(cityName: 'Sao Paulo')
        .run()
        .then((value) => value.fold((l) => print(l), (r) => print(r)));
  }
}
