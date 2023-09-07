enum ErrorTypeEnum {
  noCityFound('City not found'),
  apiRequestFailed('Api Request Error'),
  noInternetConnection('No internet connection available');

  const ErrorTypeEnum(this.errorMessage);

  final String errorMessage;
}
