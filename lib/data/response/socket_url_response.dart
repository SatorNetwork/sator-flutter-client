class SocketUrlResponse {
  final String playUrl;

  const SocketUrlResponse(this.playUrl);

  factory SocketUrlResponse.fromJson(Map json) =>
      SocketUrlResponse(json['play_url'] == null ? '' : json['play_url']);
}
