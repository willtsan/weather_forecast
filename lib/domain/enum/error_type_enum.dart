enum ErrorTypeEnum {
  noCityFound('City not found'),
  noInternetConnection('No internet connection available');

  const ErrorTypeEnum(this.errorMessage);

  final String errorMessage;
}
