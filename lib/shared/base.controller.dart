import 'package:get/get.dart';

class BaseController extends GetxController {
  final RxBool _loading = RxBool(false);
  final RxBool _error = RxBool(false);
  final RxBool _internetConnection = RxBool(true);

  String _errorMessage = "";

  bool get loading => _loading.value;
  bool get error => _error.value;
  bool get internetConnection => _internetConnection.value;

  String get errorMessage => _errorMessage;

  void startLoading() {
    _loading(true);
    hideError();
  }

  void stopLoading() {
    _loading(false);
  }

  void showError(String message) {
    _error(true);
    _errorMessage = message;
    stopLoading();
  }

  void hideError() {
    _error(false);
  }

  void noConnection() {
    _internetConnection(false);
  }

  void haveConnection() {
    _internetConnection(true);
  }
}
