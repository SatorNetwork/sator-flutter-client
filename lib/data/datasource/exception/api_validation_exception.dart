class ApiValidationException implements Exception {
  final Map<String, String?> validationMap;

  ApiValidationException(this.validationMap);
}
