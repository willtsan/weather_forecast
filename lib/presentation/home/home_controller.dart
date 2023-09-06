import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_forecast/data/models/city_model.dart';
import 'package:weather_forecast/domain/entities/weather_data_entity.dart';
import 'package:weather_forecast/domain/enum/error_type_enum.dart';
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

  late StreamSubscription<InternetStatus> listener;

  @override
  void onInit() {
    listener = InternetConnection().onStatusChange.listen(
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
            (l) => showError(l.toString()),
            (r) {
              if (r.isEmpty) {
                stopLoading();
                showError(ErrorTypeEnum.noCityFound.errorMessage);
              } else {
                fetchCity(r.first.name ?? '');
              }
            },
          ),
        );
  }

  void fetchCity(String cityName) {
    if (cityName.isEmpty) {
      stopLoading();
      showError(ErrorTypeEnum.noCityFound.errorMessage);
      return;
    }

    _geocodingDataUsecase(cityName: cityName).run().then(
          (response) => response.fold(
            (l) {
              showError(l.toString());
              stopLoading();
            },
            (geocodingResponse) {
              _getWeatherDataUsecase(
                      lat: geocodingResponse.first.lat ?? 0,
                      lon: geocodingResponse.first.lon ?? 0)
                  .run()
                  .then(
                    (response) => response.fold(
                      (l) {
                        showError(l.toString());
                        stopLoading();
                      },
                      (weatherResponse) {
                        if (geocodingResponse.first.localNames == null) {
                          stopLoading();
                          showError(ErrorTypeEnum.noCityFound.errorMessage);
                        } else {
                          addCity(
                              geocodingResponse.first.localNames != null
                                  ? geocodingResponse.first.localNames!.en ??
                                      cityName
                                  : cityName,
                              geocodingResponse.first.country ?? '',
                              weatherResponse);
                        }
                      },
                    ),
                  );
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
