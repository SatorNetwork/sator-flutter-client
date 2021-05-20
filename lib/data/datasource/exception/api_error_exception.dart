class ApiErrorException implements Exception {
  final String errorMessage;

  ApiErrorException(this.errorMessage);
}
