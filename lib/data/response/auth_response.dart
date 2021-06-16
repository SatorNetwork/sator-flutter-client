class AuthResponse {
  final String accessToken;

  const AuthResponse(this.accessToken);

  factory AuthResponse.fromJson(Map json) =>
      AuthResponse(json['access_token'] == null ? '' : json['access_token']);
}
