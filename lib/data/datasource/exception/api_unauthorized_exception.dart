class ApiUnauthorizedException implements Exception {
  final String errorMessage;

  ApiUnauthorizedException(this.errorMessage);

}
