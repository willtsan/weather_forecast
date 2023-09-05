import 'package:get/get.dart';
import 'package:weather_forecast/shared/base.controller.dart';

class DetailsController extends BaseController {
  RxString teste = RxString('teste');

  @override
  void onReady() {
    print('onready');
    print(Get.arguments);
    super.onReady();
  }

  @override
  void onInit() {
    print('oninit');
    print(Get.arguments);
    super.onInit();
  }
}
