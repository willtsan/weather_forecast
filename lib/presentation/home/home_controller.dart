import 'package:get/get.dart';
import 'package:weather_forecast/data/models/city_model.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
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

  List<String> citiesToFetch = [];

  RxList<CityModel> cities = RxList<CityModel>();

  void reset() {
    stopLoading();
    hideError();
  }

  void clear() {
    cities.clear();
  }

  void search(String term) {
    startLoading();
    _geocodingDataUsecase(cityName: term)
        .run()
        .then((response) => response.fold((l) => showError(l.toString()), (r) {
              if (r.isEmpty) {
                stopLoading();
                showError('City not found');
              } else {
                fetchCity(r.first.name ?? '');
              }
            }));
  }

  void fetchCity(String cityName) {
    if (cityName.isEmpty) {
      stopLoading();
      showError('City not found');
      return;
    }

    _geocodingDataUsecase(cityName: cityName).run().then(
          (response) => response.fold(
            (l) {
              showError(l.toString());
              stopLoading();
            },
            (r) {
              _getWeatherDataUsecase(
                      lat: r.first.lat ?? 0, lon: r.first.lon ?? 0)
                  .run()
                  .then(
                    (response) => response.fold(
                      (l) {
                        showError(l.toString());
                        stopLoading();
                      },
                      (r2) {
                        if (r.first.localNames == null) {
                          stopLoading();
                          showError('City not found');
                        } else {
                          addCity(
                              r.first.localNames != null
                                  ? r.first.localNames!.en ?? cityName
                                  : cityName,
                              r2);
                        }
                      },
                    ),
                  );
            },
          ),
        );
  }

  void addCity(String cityName, WeatherDataEntity weather) {
    cities.add(CityModel(cityName: cityName, weather: weather));
    stopLoading();
  }
}
