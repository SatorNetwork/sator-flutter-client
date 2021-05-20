class ErrorResponse {
  final String error;

  const ErrorResponse(this.error);

  factory ErrorResponse.fromJson(Map json) =>
      ErrorResponse(json['error'] as String);
}
