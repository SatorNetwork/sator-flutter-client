class AuthResponse {
  final String accessToken;

  const AuthResponse(this.accessToken);

  factory AuthResponse.fromJson(Map json) =>
      AuthResponse(json['access_token'] as String);
}
