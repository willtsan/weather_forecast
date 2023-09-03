import 'package:get/get.dart';
import 'package:weather_forecast/data/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/data/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/data/repository/get_geocoding_data_repository.dart';
import 'package:weather_forecast/data/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/data/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/data/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/domain/datasource/get_geocoding_data_datasource.dart';
import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/repository/get_geocoding_data_repository.dart';
import 'package:weather_forecast/domain/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/domain/usecase/get_geocoding_data_usecase.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/presentation/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetWeatherDataDatasource>(
        () => GetWeatherDataDatasource(
              httpClient: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<IGetGeocodingDataDatasource>(
        () => GetGeocodingDataDatasource(
              httpClient: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<IGetWeatherDataRepository>(
        () => GetWeatherDataRepository(
              getWeatherDataDatasource: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<IGetGeocodingDataRepository>(
        () => GetGeocodingDataRepository(
              getGeocodingDataDatasource: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<IGetWeatherDataUsecase>(
        () => GetWeatherDataUsecase(
              getWeatherDataRepository: Get.find(),
            ),
        fenix: true);
    Get.lazyPut<IGetGeocodingDataUsecase>(
        () => GetGeocodingDataUsecase(
              getGeocodingDataRepository: Get.find(),
            ),
        fenix: true);

    Get.lazyPut(
        () => HomeController(
              getWeatherDataUsecase: Get.find(),
              geocodingDataUsecase: Get.find(),
            ),
        fenix: true);
  }
}
