import 'package:get/get.dart';
import 'package:weather_forecast/presentation/details/details_controller.dart';

class DetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController(), fenix: true);
  }
}
