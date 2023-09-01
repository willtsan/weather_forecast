import 'package:get/get.dart';
import 'package:weather_forecast/data/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/data/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/data/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/domain/datasource/get_weather_data_datasource.dart';
import 'package:weather_forecast/domain/repository/get_weather_data_repository.dart';
import 'package:weather_forecast/domain/usecase/get_weather_data_usecase.dart';
import 'package:weather_forecast/presentation/home/home.controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetWeatherDataDatasource>(() => GetWeatherDataDatasource(),
        fenix: true);
    Get.lazyPut<IGetWeatherDataRepository>(
        () => GetWeatherDataRepository(getWeatherDataDatasource: Get.find()),
        fenix: true);
    Get.lazyPut<IGetWeatherDataUsecase>(
        () => GetWeatherDataUsecase(getWeatherDataRepository: Get.find()),
        fenix: true);

    Get.lazyPut(() => HomeController(getWeatherDataUsecase: Get.find()),
        fenix: true);
  }
}
