class AuthResponse {
  final String accessToken;

  const AuthResponse(this.accessToken);

  factory AuthResponse.fromJson(Map json) =>
      AuthResponse(json['data']['access_token'] as String);
}
