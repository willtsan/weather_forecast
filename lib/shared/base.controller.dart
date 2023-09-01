import 'package:get/get.dart';

class BaseController extends GetxController {
  final RxBool _loading = RxBool(false);
  final RxBool _error = RxBool(false);
  final String _errorMessage = "";

  bool get loading => _loading.value;
  bool get error => _error.value;

  String get errorMessage => _errorMessage;

  void startLoading() {
    _loading(true);
    hideError();
  }

  void stopLoading() {
    _loading(false);
  }

  void showError() {
    _error(true);
    stopLoading();
  }

  void hideError() {
    _error(false);
  }
}
