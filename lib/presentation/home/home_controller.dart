import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_forecast/data/models/city_model.dart';
import 'package:weather_forecast/domain/entities/geocoding_data_entity.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/enum/error_type_enum.dart';
import 'package:weather_forecast/domain/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/shared/base.controller.dart';

class HomeController extends BaseController {
  final IGetWeatherDataUsecase _getWeatherDataUsecase;
  final IGetGeocodingDataUsecase _geocodingDataUsecase;
  final InternetConnection _internetConnection;

  HomeController(
      {required IGetWeatherDataUsecase getWeatherDataUsecase,
      required IGetGeocodingDataUsecase geocodingDataUsecase,
      required InternetConnection internetConnection})
      : _getWeatherDataUsecase = getWeatherDataUsecase,
        _geocodingDataUsecase = geocodingDataUsecase,
        _internetConnection = internetConnection;

  List<String> citiesToFetch = [];

  RxList<CityModel> cities = RxList<CityModel>();

  late StreamSubscription<InternetStatus> listener;

  @override
  void onInit() {
    listener = _internetConnection.onStatusChange.listen(
      (InternetStatus status) {
        switch (status) {
          case InternetStatus.connected:
            haveConnection();
            break;
          case InternetStatus.disconnected:
            noConnection();
            break;
        }
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }

  void reset() {
    stopLoading();
    hideError();
  }

  void clear() {
    cities.clear();
  }

  void search(String term) {
    if (!internetConnection) {
      showError(ErrorTypeEnum.noInternetConnection.errorMessage);
      return;
    }

    startLoading();
    _geocodingDataUsecase(cityName: term).run().then(
          (response) => response.fold(
            (l) {
              stopLoading();
              showError(ErrorTypeEnum.noCityFound.errorMessage);
            },
            (r) {
              if (r.isEmpty) {
                stopLoading();
                showError(ErrorTypeEnum.noCityFound.errorMessage);
              } else {
                fetchCity(r.first);
              }
            },
          ),
        );
  }

  void fetchCity(GeocodingDataEntity city) {
    _getWeatherDataUsecase(lat: city.lat ?? 0, lon: city.lon ?? 0).run().then(
          (response) => response.fold(
            (l) {
              showError(ErrorTypeEnum.apiRequestFailed.errorMessage);
              stopLoading();
            },
            (weatherResponse) {
              if (city.localNames == null) {
                stopLoading();
                showError(ErrorTypeEnum.noCityFound.errorMessage);
              } else {
                addCity(
                    city.localNames != null
                        ? city.localNames!.en ?? city.name!
                        : city.name!,
                    city.country ?? '',
                    weatherResponse);
              }
            },
          ),
        );
  }

  void addCity(String cityName, String country, WeatherDataEntity weather) {
    for (var city in cities) {
      if (city.cityName == "$cityName, $country") {
        cities.remove(city);
        break;
      }
    }
    cities.add(CityModel(cityName: "$cityName, $country", weather: weather));
    cities.value = cities.reversed.toList();
    stopLoading();
  }
}
