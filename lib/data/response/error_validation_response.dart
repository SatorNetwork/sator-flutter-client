class ErrorValidationResponse {
  final Map<String, String?> validation;

  const ErrorValidationResponse(this.validation);

  factory ErrorValidationResponse.fromJson(Map json) {
    Map<String, String?> data = {};

    if (json['error'] is Map)
      json['error'].forEach((key, value) {
        String? keyData;
        if (value is Iterable) {
          keyData = value.join();
        }
        if (value is String) {
          keyData = value;
        }
        data[key] = keyData;
      });

    return ErrorValidationResponse(data);
  }
}
