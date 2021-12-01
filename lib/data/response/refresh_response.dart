class RefreshResponse {
  final String refreshToken;

  const RefreshResponse(this.refreshToken);

  factory RefreshResponse.fromJson(Map json) =>
      RefreshResponse(json['refresh_token'] == null ? '' : json['refresh_token']);
}
