import 'package:get/get.dart';
import 'package:weather_forecast/data/models/city_model.dart';
import 'package:weather_forecast/shared/base.controller.dart';

class DetailsController extends BaseController {
  Rxn<CityModel> cityData = Rxn<CityModel>(null);

  @override
  void onReady() {
    cityData(Get.arguments as CityModel);
    super.onReady();
  }
}
